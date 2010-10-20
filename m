From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: including sparse headers in C++ code
Date: Wed, 20 Oct 2010 08:29:45 +0100
Message-ID: <20101020072945.GA3232@ZenIV.linux.org.uk>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
 <1286710919.24953.2.camel@thorin>
 <201010101352.10864.kdudka@redhat.com>
 <1286790249.24953.14.camel@thorin>
 <AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
 <20101011191219.GD8537@feather>
 <1286981110.14103.86.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54454 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450Ab0JTH36 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 20 Oct 2010 03:29:58 -0400
Content-Disposition: inline
In-Reply-To: <1286981110.14103.86.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: Christopher Li <sparse@chrisli.org>, Kamil Dudka <kdudka@redhat.com>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>

On Wed, Oct 13, 2010 at 04:45:10PM +0200, Bernd Petrovitsch wrote:

> rename the local variables "true" and "false" to "if_true" and "if_false",
> respectively to not clash with the well-known "keywords" defined by C99.
> This is similar to commit 0be55c9.

These are not keywords...  Said that, things like
                if (!cond->value)
                        true = false;
                if (!true)
                        true = cond;
certainly reek of IOCCC.  I'd rather avoid "if_true" as replacement, though.
If anything, true_expr and false_expr would make more sense.
