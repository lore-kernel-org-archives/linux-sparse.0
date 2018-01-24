From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] test-suite: handle format with filename.c not existing
Date: Wed, 24 Jan 2018 09:28:15 +0100
Message-ID: <20180124082814.a36sur5e7cusrleb@ltop.local>
References: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34879 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeAXI2S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 24 Jan 2018 03:28:18 -0500
Received: by mail-wm0-f47.google.com with SMTP id r78so6841442wme.0
        for <linux-sparse@vger.kernel.org>; Wed, 24 Jan 2018 00:28:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Mon, Jan 22, 2018 at 11:05:09AM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> In error(), quiet is undefined when the command:
>   $ ./test-suite format filename1.c foobar1
> 
> is used and filename1.c does not exist. This causes a shell script error:
>   ./test-suite: line 147: [: : integer expression expected
> 
> because $quiet is undefined in
>   [ "$quiet" -ne 1 ] && echo "error: $1"
> so the error message is lost.
> 
> Just initialize quiet before any command line parsing.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

cfr: https://marc.info/?l=linux-sparse&m=151273892009415

-- Luc
