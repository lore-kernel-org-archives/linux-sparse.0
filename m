From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Tue, 22 Nov 2016 19:39:37 +0800
Message-ID: <CANeU7Qm_LyVPzdSxVEn8r1LDEGFsfVJgXW45id-KK19=JhbT6Q@mail.gmail.com>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net> <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38456 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbcKVLji (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 06:39:38 -0500
Received: by mail-it0-f45.google.com with SMTP id j191so9417284ita.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 03:39:38 -0800 (PST)
In-Reply-To: <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Nov 22, 2016 at 7:13 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Nov 21, 2016 at 5:45 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
>> Yes, that'd make some sense. I have no idea how to pull it off though
>
> I take a brief look.
>
> It seems that you need to implement a symbol with ".expand" implement as
> "expand_bswap", similar to "expand_constant_p".

Never mind that, I just find out expand stage happen after the evaluation
stage. The warning happen in the evaluation stage. It will need to make some
plan change to get it right.

Chris
