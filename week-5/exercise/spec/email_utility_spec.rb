require './models/email_utility.rb'

describe EmailUtility do
    it "sender should present" do
        
        valid = EmailUtility.send_email("tes@tes.com")

        expect(valid).to eq(true)
    end 
end