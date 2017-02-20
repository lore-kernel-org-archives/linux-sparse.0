From: Edward Cree <ecree@solarflare.com>
Subject: Re: [RFC PATCH 1/2] Allow casting to a restricted type if
 !restricted_value
Date: Mon, 20 Feb 2017 11:52:03 +0000
Message-ID: <19d73ab0-d008-a011-e04c-568614cb621d@solarflare.com>
References: <e8e65c94-4d07-b20e-1bdb-30c7a8d1108f@solarflare.com>
 <1d8e35fa-643b-afa4-8089-f5a945a50eef@solarflare.com>
 <20170217175847.mq6mgml47cagxcah@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:12262 "EHLO
        nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751402AbdBTLxS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Feb 2017 06:53:18 -0500
In-Reply-To: <20170217175847.mq6mgml47cagxcah@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On 17/02/17 20:23, Luc Van Oostenryck wrote:
> On Fri, Feb 17, 2017 at 03:11:15PM +0000, Edward Cree wrote:
>> If the operand of a cast to a restricted type is an unrestricted value,
>>  the cast should not produce a warning, since an equivalent implied cast
>>  (e.g. in an initialiser) would not do so.
>>
>> Signed-off-by: Edward Cree <ecree@solarflare.com>
>> ---
>>  evaluate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/evaluate.c b/evaluate.c
>> index e350c0c..8e855b1 100644
>> --- a/evaluate.c
>> +++ b/evaluate.c
>> @@ -2771,7 +2771,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
>>                 t2 = unfoul(t2);
>>
>>         if (t1 != t2) {
>> -               if (class1 & TYPE_RESTRICT)
>> +               if ((class1 & TYPE_RESTRICT) && restricted_value(target, t1))
>>                         warning(expr->pos, "cast to %s",
>>                                 show_typename(t1));
>>                 if (class2 & TYPE_RESTRICT)
> I'm fine with this.
>
> Just the 't1' in restricted_value() that should probably be 't2'
> (as can be seen on the warnings, just below t1 is the destination type
> and t2 is the origin type) but since this argument is not used anyway
> and the semantic of this not defined, it won't matter at all.
> Maybe best to use NULL.
As far as I can tell, restricted_value() is supposed to take the type to
 which the value is being converted.  Looking at the other call sites,
 restricted_binop_type() for example calls it on (right, ltype) and on
 (left, rtype), in order to determine a common type.
I think in fact restricted_value() already has access to t2, it comes from
 target->ctype and we're passing in target.
> Also, I think it would be best to squash the two patches together.
Sure, I'll do that when I re-send.
> (And I think you will need to resend it from another email address
> because of the notice automatically added to your emails).
Every time I send to a new mailing list I have to get it whitelisted.
Sigh.  Hopefully this mail shouldn't get the notice tacked on...
-Ed
