From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Wed, 23 Nov 2016 07:28:27 +0100
Message-ID: <1479882507.4432.1.camel@sipsolutions.net>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
         <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
         <1479721551.8662.10.camel@sipsolutions.net>
         <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
         <20161122131543.GA8370@macbook.local>
         <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
         (sfid-20161122_174738_216238_D863CDDD)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36110 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932417AbcKWG2a (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 01:28:30 -0500
In-Reply-To: <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com> (sfid-20161122_174738_216238_D863CDDD)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>


> I get it working in the end. Not too far from what I thought.
> Patch attach here for review.

Just a small comment:

> +       if (expression_list_size(args) != 1) {
> +               sparse_error(expr->pos, "not enough arguments for function %s",
> +                               show_ident(sym->ident));

Should that say "invalid number of arguments (expected 1)" or so?

johannes
