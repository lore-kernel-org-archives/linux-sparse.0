From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse release v0.5.1-rc1
Date: Tue, 13 Jun 2017 18:05:13 +0200
Message-ID: <20170613160511.fkjvpulf7mhzqi7z@ltop.local>
References: <CANeU7QnnwD5+XDp-C1-4oxrD8Vn-tMWhoNC8NBv0M36PO9J2fQ@mail.gmail.com>
 <20170613045829.p4ilb7xjxg35hzvm@ltop.local>
 <5396b5dd-8a26-238c-19b3-12132a9a556b@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35093 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdFMQFS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 12:05:18 -0400
Received: by mail-wr0-f170.google.com with SMTP id q97so150222783wrb.2
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jun 2017 09:05:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5396b5dd-8a26-238c-19b3-12132a9a556b@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jun 13, 2017 at 04:08:23PM +0100, Ramsay Jones wrote:
> Luc, I have not actually tested these patches (I was waiting for
> something I could git-fetch). I have no doubt they are good, but

This -rc1 is in fact the parent of the mem-max-count mini-series,
so you tested it already a bit :)

> it just occurred to me that a patch may be missing. I don't recall
> seeing a change to cgcc to filter-out the new, sparse only, options.
> ie. they need to be added to the check_only_option subroutine (#102).

Indeed, it's really great that you thought about it
because since I don't use cgcc myself, I would never
have thought about updated it.

I'll add what is needed and check if anything else is
missing there.

Thank you very much to bringing this to my attention.
-- Luc
