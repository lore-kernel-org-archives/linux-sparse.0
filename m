From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 02/63] allow binop simplification after
 canonicalization
Date: Fri, 24 Mar 2017 10:43:52 +0100
Message-ID: <20170324094351.opuea4bvzr7uorym@macpro.local>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
 <20170321001607.75169-3-luc.vanoostenryck@gmail.com>
 <CANeU7QkUC1kZPq8s_Z-HWWri=edi6SczhGEaNFydEArRcN2J8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34603 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965371AbdCXJoB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 05:44:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so2096326wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 02:44:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QkUC1kZPq8s_Z-HWWri=edi6SczhGEaNFydEArRcN2J8w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 23, 2017 at 10:00:17PM -0700, Christopher Li wrote:
> On Mon, Mar 20, 2017 at 5:15 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  simplify.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> Looks good. It would be nice to have some test code to show the effect
> of this change.

There is no visible effect to show, in fact it would be an error
if there any.

Before the patch if some simplication was made, we returned
directly to the CSE/simplification loop and canonicalization
was done at some later cycles, once all simplifications had been
made. But the goal of canonicalization is to limit the number of
cases/patterns we need to check/handle during ... simplification.

So canonicalization need to be done before the simplification.
The fact that this patch also allow us to spare one cycle
of CSE/simplification is just a nice side-effect.

The real motivation was to prepare code for the following patch.

Yes, I've been lazy in the message log, I'll update it.

-- Luc
