From: Chris Forbes <chrisf@ijw.co.nz>
Subject: Re: [PATCH 3/3] evaluate: warn on identical exprs on ?:
Date: Sun, 28 Aug 2011 14:51:10 +1200
Message-ID: <CAH3ygc0h9KD6gPRj-72s1M199Di+YqkSjwqazSaQVgvp+LLQtA@mail.gmail.com>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
	<1314484015-7694-3-git-send-email-chrisf@ijw.co.nz>
	<20110828024618.GA20823@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58828 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab1H1CvL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 22:51:11 -0400
Received: by gwaa12 with SMTP id a12so3925582gwa.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 19:51:11 -0700 (PDT)
In-Reply-To: <20110828024618.GA20823@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

Thanks Josh -- that is a bit messy, the change to that guard does need
pushed down into the first patch. I'll fix that, any other things to
change before I resubmit?

-- Chris

On Sun, Aug 28, 2011 at 2:46 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
> On Sun, Aug 28, 2011 at 10:26:55AM +1200, Chris Forbes wrote:
>> Adds a warning when identical expressions are found on both the true=
 and false branches of ?:. This is another common copy-paste error.
>>
>> Signed-off-by: Chris Forbes <chrisf@ijw.co.nz>
>> ---
>> =A0evaluate.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A08 +++++++-
>> =A0validation/check_identical_exprs_on_cond.c | =A0 13 +++++++++++++
>> =A02 files changed, 20 insertions(+), 1 deletions(-)
>> =A0create mode 100644 validation/check_identical_exprs_on_cond.c
>>
>> diff --git a/evaluate.c b/evaluate.c
>> index 11de7aa..c339e63 100644
>> --- a/evaluate.c
>> +++ b/evaluate.c
>> @@ -898,7 +898,7 @@ static int expr_list_equiv(struct expression_lis=
t *lhs,
>> =A0int expr_equiv(struct expression *lhs, struct expression *rhs)
>> =A0{
>> =A0 =A0 =A0 /* recursively determine if lhs ~ rhs. */
>> - =A0 =A0 if (!lhs ^ !rhs) return 0;
>> + =A0 =A0 if (!lhs || !rhs) return 0;
>
> You introduced this earlier in the same patch series. =A0This looks l=
ike
> it needs some patch cleanup.
>
> - Josh Triplett
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
