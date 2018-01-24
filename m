From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] test-suite: handle format with filename.c not existing
Date: Wed, 24 Jan 2018 09:15:20 +0100
Message-ID: <20180124081519.6j3pap5k2kj2dpbb@ltop.local>
References: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
 <CANeU7QkL3UrbsHRVhwXcAas7cBOTVyzHsGzZSKr0zAiEBFAWpg@mail.gmail.com>
 <2386463a-5601-78d5-6827-5f03321e4adb@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37060 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeAXIPZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 24 Jan 2018 03:15:25 -0500
Received: by mail-wm0-f45.google.com with SMTP id v71so6753930wmv.2
        for <linux-sparse@vger.kernel.org>; Wed, 24 Jan 2018 00:15:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2386463a-5601-78d5-6827-5f03321e4adb@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jan 23, 2018 at 10:20:55AM -0800, Randy Dunlap wrote:
> 
> At the beginning of the file, $must_fail is not defined, so it will not -eq 1,
> so quiet will remain = 0.
> 
> I guess that I don't understand the interplay between $V and $quiet and why
> have both of them.

$V is something global, set once for all when starting the test suite.
$quiet is something that can change for each file being tested.

> Are you suggesting that $quiet should be initialized by default like this:
> (just drop the $must_fail part)
> 
> > quiet=0
> > [ $V -eq 0 ] && quiet=1

The whole can probably be simplified a bit but the idea with
$must_fail (set for test cases we known/expected to fail) is
that we're not interested in any sort of details about the
failure of a test that is supposed to fail.

Regards,
-- Luc
