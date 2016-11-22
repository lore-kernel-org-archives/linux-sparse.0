From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Tue, 22 Nov 2016 14:15:44 +0100
Message-ID: <20161122131543.GA8370@macbook.local>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net>
 <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33453 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755131AbcKVNPr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 08:15:47 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so3733314wmu.0
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 05:15:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Tue, Nov 22, 2016 at 07:13:11PM +0800, Christopher Li wrote:
> 
> Otherwise, expand_bswap should proceed to calculate the return
> value of the bswap call and rewrite the call expression into a constant.
> Some what similar to the "__builtin_constant_p".
> 
> I will see if I can hack up some thing very quick.
> 
> Chris
> --

I think it would be best to do any change related tos handling
of constant expressions on to of Nicolai Stange's serie:
	http://marc.info/?l=linux-sparse&m=145429372932235

Not only this serie fixes several issues but it handle the
expression constantnes in a much more systematic way.
Also, I wouldn't like that changes in this area make it
more difficult to integrate this serie (which is already waiting
since July or August 2015).

Luc
