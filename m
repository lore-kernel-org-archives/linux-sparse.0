From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: Re: Context imbalance false positive
Date: Fri, 18 Jul 2008 07:25:18 -0700
Message-ID: <43e72e890807180725q4e1f0c8fu1da7185ade275aa1@mail.gmail.com>
References: <43e72e890807171652r133c973dh160ea28d361a4601@mail.gmail.com>
	 <1216369525.27738.4.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.191]:34766 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYGROZU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Jul 2008 10:25:20 -0400
Received: by rn-out-0910.google.com with SMTP id k40so131637rnd.17
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2008 07:25:18 -0700 (PDT)
In-Reply-To: <1216369525.27738.4.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org

On Fri, Jul 18, 2008 at 1:25 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Thu, 2008-07-17 at 16:52 -0700, Luis R. Rodriguez wrote:
>> I'm not sure how to resolve a situation like this:
>
>> static void lock(int bh_flag)
>> {
>>         if (bh_flag)
>>                 spin_lock_bh(&some_lock);
>>         else
>>                 spin_lock(&some_lock);
>
> The only generally accepted way is to not program locking dependent on
> flags.

Agreed, and that's what I'm trying to do actually. I think the above
is pure absolute garbage.

> You can sneak in sparse annotations to do it anyway, but I won't tell
> you how :)

If you mean by __acquires() and __releases() then that didn't help.

  Luis
