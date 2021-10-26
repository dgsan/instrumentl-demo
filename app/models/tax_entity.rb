class TaxEntity < ApplicationRecord
  include FlagShihTzu

  has_flags 1 => :grants,
            2 => :receives

  has_many :granted, class_name: 'Grant', inverse_of: :from, foreign_key: :from_ein, primary_key: :ein
  has_many :received, class_name: 'Grant', inverse_of: :to, foreign_key: :to_ein, primary_key: :ein
  has_many :granted_to, through: :granted, source: :to


  # Ordinarily, I'd prefere to encapsulate this business logic in a code
  # tree dedicated to business logic, but this fits best here (or in a
  # helper given short timeline.) (And I dislike model-helpers because often
  # methods end up relatively unrelated to the model. Their methods should be
  # organized on a different axis, e.g. similar tasks, or business logic.)
  def self.load_990(url)
    logger.info "LOADING DOC #{url}"
    temp = Down.download(url, max_size: 16 * 1024 * 1024)
    # Note: likely a variety reasons to do this a different way.
    # But it was fast and I hate typing xmlns all over.
    Hash.from_xml(temp).tap do |data|
      return_date = data.dig("Return","ReturnHeader","TaxPeriodEndDate") ||
                    data.dig("Return","ReturnHeader","TaxPeriodEndDt")
      data["Return"]["ReturnHeader"]["Filer"].tap do |filer|
        address = filer["USAddress"]
        name = filer["Name"] || filer["BusinessName"]
        TaxEntity
        .find_or_initialize_by(ein: filer["EIN"])
        .update!(
          ein: filer["EIN"],
          name: name["BusinessNameLine1"] || name["BusinessNameLine1Txt"],
          address: address["AddressLine1"] || address["AddressLine1Txt"],
          city: address["City"] || address["CityNm"],
          state: address["State"] || address["StateAbbreviationCd"],
          post_code: address["ZIPCode"] || address["ZIPCd"],
          grants: true
        )
        recipients = data.dig("Return","ReturnData","IRS990ScheduleI","RecipientTable")
        (recipients || []).each { |rec| load_recipient(rec, filer["EIN"], return_date[0..3]) }
      end
    end
  end

  # Created the model before determining that recipients don't always
  # have EINs. Given I'd created schema assuming EIN would be the main
  # system identifier rather than an internal ID... doing something
  # whacky to save time here.
  def self.load_recipient(rec, granter_ein, year)
    amount = rec["CashGrantAmt"] || rec["AmountOfCashGrant"]
    name_wrap = rec["RecipientBusinessName"] || rec["RecipientNameBusiness"]
    name = name_wrap["BusinessNameLine1"] || name_wrap["BusinessNameLine1Txt"]
    address_wrap = rec["USAddress"] || rec["AddressUS"]
    address = address_wrap["AddressLine1"] || address_wrap["AddressLine1Txt"]
    city = address_wrap["City"] || address_wrap["CityNm"]
    state = address_wrap["State"] || address_wrap["StateAbbreviationCd"]
    post_code = address_wrap["ZIPCode"] || address_wrap["ZIPCd"]
    ein = rec.dig("RecipientEIN") || rec.dig("EINOfRecipient")
    unless ein
      ein = "dummy_ein_" + Digest::SHA256.hexdigest("tax-#{name}#{state}#{post_code}-entity")
    end
    TaxEntity
    .find_or_initialize_by(ein: ein)
    .update!(
      ein: ein,
      name: name,
      address: address,
      city: city,
      state: state,
      post_code: post_code,
      receives: true
    )
    Grant.find_or_initialize_by(from_ein: granter_ein, to_ein: ein, year: year)
    .update!(
      from_ein: granter_ein,
      to_ein: ein,
      year: year,
      amount: amount
    )
  end
end
