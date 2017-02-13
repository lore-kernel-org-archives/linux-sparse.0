From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 0/3] builtins expansion
Date: Mon, 13 Feb 2017 09:54:45 +0800
Message-ID: <CANeU7Q=k85TMZFR839r5U3OoVADmmqtmk9aEWyBHuSnpug5d1A@mail.gmail.com>
References: <20170212150332.33xlxmzohgb7hrpp@macpro.local> <20170212151100.15868-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33666 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdBMByr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 20:54:47 -0500
Received: by mail-it0-f67.google.com with SMTP id e137so10769713itc.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 17:54:46 -0800 (PST)
In-Reply-To: <20170212151100.15868-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>

On Sun, Feb 12, 2017 at 11:10 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This serie solves the problem of the expansion of some builtins
> like __builtin_bswap16() which gcc consider as an integer constant
> expression when the arg is itself an integer constant.
> Such builtins are used as such in the kernel and their non-expansion
> create undesirable warnings from sparse.

Applied in sparse-next.

Chris
