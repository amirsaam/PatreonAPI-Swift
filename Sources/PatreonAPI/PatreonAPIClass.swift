//
//  PatreonAPI.swift
//
//
//  Created by Amir Mohammadi on 11/13/1401 AP.
//

import Foundation

// MARK: - Patreon Class
public final class PatreonAPI {
    internal let clientID: String
    internal let clientSecret: String
    internal let creatorAccessToken: String
    internal let creatorRefreshToken: String
    internal let redirectURI: String
    internal let campaignID: String
    
    public init(clientID: String,
                clientSecret: String,
                creatorAccessToken: String,
                creatorRefreshToken: String,
                redirectURI: String,
                campaignID: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.creatorAccessToken = creatorAccessToken
        self.creatorRefreshToken = creatorRefreshToken
        self.redirectURI = redirectURI
        self.campaignID = campaignID
    }

    // Because some of Patreon's API query values are too long, we store them as variables to be readable
    internal let fieldsUserQueryValue = """
                                about,
                                can_see_nsfw,
                                created,
                                email,
                                first_name,
                                full_name,
                                hide_pledges,
                                image_url,
                                is_email_verified,
                                last_name,
                                like_count,
                                social_connections,
                                thumb_url,
                                url,
                                vanity
                                """

    internal let fieldsCampaignQueryValue = """
                                created_at,
                                creation_name,
                                discord_server_id,
                                google_analytics_id,
                                has_rss,
                                has_sent_rss_notify,
                                image_small_url,
                                image_url,
                                is_charged_immediately,
                                is_monthly,
                                is_nsfw,
                                main_video_embed,
                                main_video_url,
                                one_liner,
                                patron_count,
                                pay_per_name,
                                pledge_url,
                                published_at,
                                rss_artwork_url,
                                rss_feed_title,
                                show_earnings,
                                summary,
                                thanks_embed,
                                thanks_msg,
                                thanks_video_url,
                                url,
                                vanity
                                """

    internal let fieldsTierQueryValue = """
                                amount_cents,
                                created_at,
                                description,
                                discord_role_ids,
                                edited_at,
                                image_url,
                                patron_count,
                                post_count,
                                published,
                                published_at,
                                remaining,
                                requires_shipping,
                                title,
                                unpublished_at,
                                url,
                                user_limit
                                """

    internal let fieldsBenefitQueryValue = """
                                app_external_id,
                                app_meta,
                                benefit_type,
                                created_at,
                                deliverables_due_today_count,
                                delivered_deliverables_count,
                                description,
                                is_deleted,
                                is_ended,
                                is_published,
                                next_deliverable_due_date,
                                not_delivered_deliverables_count,
                                rule_type,
                                tiers_count,
                                title
                                """

    internal let fieldsMemberQueryValue = """
                                campaign_lifetime_support_cents,
                                currently_entitled_amount_cents,
                                email,
                                full_name,
                                is_follower,
                                last_charge_date,
                                last_charge_status,
                                lifetime_support_cents,
                                next_charge_date,
                                note,
                                patron_status,
                                pledge_cadence,
                                pledge_relationship_start,
                                will_pay_amount_cents
                                """

    internal let fieldsAddressQueryValue = """
                                addressee,
                                city,
                                country,
                                created_at,
                                line_1,
                                line_2,
                                phone_number,
                                postal_code,
                                state
                                """
}
