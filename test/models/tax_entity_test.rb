require "test_helper"

class TaxEntityTest < ActiveSupport::TestCase

  #
  # Ordinarily, I'd probably put this somewhere else,
  # but figuring out where to organize a document loader
  # is out of scope for timeline.
  #
  test "IRS documents match expectations" do
    irs = YAML.load(File.read(Rails.root.join("config/irs_docs.yaml")))
    irs["documents"].each do |url|
      temp = Down.download(url, max_size: 16 * 1024 * 1024)
      Hash.from_xml(temp).tap do |doc|
        assert doc.dig("Return", "ReturnHeader", "Filer")
        doc["Return"]["ReturnHeader"]["Filer"].tap do |filer|
          ["EIN", "USAddress"].each do |field|
            assert filer[field]
          end
          assert filer["Name"] || filer["BusinessName"]
          (filer["Name"] || filer["BusinessName"]).tap do |name|
            assert name["BusinessNameLine1"] || name["BusinessNameLine1Txt"]
          end
          filer["USAddress"].tap do |address|
            assert address["AddressLine1"] || address["AddressLine1Txt"]
            assert address["City"] || address["CityNm"]
            assert address["State"] || address["StateAbbreviationCd"]
            assert address["ZIPCode"] || address["ZIPCd"]
          end
        end
        if doc.dig("Return", "ReturnData","IRS990ScheduleI")
          assert doc.dig("Return", "ReturnData", "IRS990ScheduleI", "RecipientTable")
          assert doc["Return"]["ReturnData"]["IRS990ScheduleI"]["RecipientTable"].length > 0
          doc["Return"]["ReturnData"]["IRS990ScheduleI"]["RecipientTable"].each do |rec|
            assert rec["CashGrantAmt"] || rec["AmountOfCashGrant"]
            assert rec["RecipientBusinessName"] || rec["RecipientNameBusiness"]
            (rec["RecipientBusinessName"] || rec["RecipientNameBusiness"]).tap do |bus|
              assert bus["BusinessNameLine1"] || bus["BusinessNameLine1Txt"]
            end
            assert rec["USAddress"] || rec["AddressUS"]
            (rec["USAddress"] || rec["AddressUS"]).tap do |address|
              assert address["AddressLine1"] || address["AddressLine1Txt"]
              assert address["City"] || address["CityNm"]
              assert address["State"] || address["StateAbbreviationCd"]
              assert address["ZIPCode"] || address["ZIPCd"]
            end
            # This is a terrible test, but wasn't sure
            # just how crazy keys could get.
            if rec.keys.any? { |k| /.*ein.*/ =~ k.downcase }
              assert rec["RecipientEIN"] || rec["EINOfRecipient"]
            end
          end
        end
      end
    end
  end
end
