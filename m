From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] remove warning "call with no type"
Date: Sat, 10 Feb 2018 20:54:33 +0100
Message-ID: <20180210195431.nqtd6smqvmvtlcqp@ltop.local>
References: <20180131104043.3345-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnp+3nLjE7AZ=tMOA4OmjEa3j_XQe6UgUHd2_e5W4fTiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:53583 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeBJTyg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Feb 2018 14:54:36 -0500
Received: by mail-wm0-f49.google.com with SMTP id t74so3150656wme.3
        for <linux-sparse@vger.kernel.org>; Sat, 10 Feb 2018 11:54:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qnp+3nLjE7AZ=tMOA4OmjEa3j_XQe6UgUHd2_e5W4fTiA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Feb 10, 2018 at 11:00:26AM -0800, Christopher Li wrote:
> On Wed, Jan 31, 2018 at 2:40 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > This warning is issued when trying to linearize a call
> > expressions with a null expr->ctype but such null ctype
> > is a consequence of an error detected during evaluation
> > and this error must already have issued a warning or an
> > error message specific to the problem.
> >
> > In short, this "call with no type" is non-informative
> > and redundant, so avoid usless noise and remove this
> > warning.
> 
> The change looks fine to me. This the change assume the
> expr->ctype be NULL is result of an error and has been reported
> before. I am sure that assumption holds for most of the cases. Not
> sure it holds for all corner cases.

I consider that if it this not the case, it's a bug which
will need to be fixed by adding the proper error reporting.
But I haven't yet seen such case.

-- Luc
