From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Handling of local variables in the backend
Date: Wed, 13 Sep 2017 12:18:43 +0200
Message-ID: <20170913101842.ax5eiyoe5dgliibe@ltop.local>
References: <CACXZuxd2XOKBaTnPEGEy-XZPTg_PJrA_XnNUfbbHm2X7zxKcmA@mail.gmail.com>
 <CANeU7QmiSJ2NFykLn__EaeCK03d4zzGBttFa=Skcn487C-RdjQ@mail.gmail.com>
 <CACXZuxcapzEcNs6v00TCRWxzETsGoMAD1hLk9YJEJw+5HBdBTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:46860 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbdIMKSs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Sep 2017 06:18:48 -0400
Received: by mail-wm0-f54.google.com with SMTP id i189so2861632wmf.1
        for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2017 03:18:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcapzEcNs6v00TCRWxzETsGoMAD1hLk9YJEJw+5HBdBTg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 13, 2017 at 10:56:16AM +0100, Dibyendu Majumdar wrote:
> Hi Chris,
> 
> On 12 September 2017 at 23:44, Christopher Li <sparse@chrisli.org> wrote:
> > On Tue, Sep 12, 2017 at 5:54 PM, Dibyendu Majumdar
> > <mobile@majumdar.org.uk> wrote:
> >>
> >> I think that there is no easy way to identify all the symbols used for
> >> which stack space is needed and do the allocas at the start - is
> >> there? I mean the only way is to go through all the instructions to
> >> find these references as far as I know.
> >
> >
> > Have you try the sym->symbol_list for the function node?
> > It should contain all the symbol used in that function.
> >
> 
> Did you mean struct entrypoint -> syms instead?
> I see that this contains a list of symbols ... I don't know if this is
> guaranteed to have all symbols defined in the function.

ep->accesses contains all the pseudos corresponding to the symbols
used for doing load & store accesses.

So, you probably should doing something like: 

	pseudo_t pseudo;

	FOR_EACH_PTR(ep->accesses, pseudo) {
		struct symbol *sym = pseudo->sym;
		unsigned log mods = sym->ctype.modifiers;

		if (mods & MOD_VOLATILE)
			...
		if (mods & (MOD_NONLOCAL | MOD_STATIC | MOD_ADDRESSABLE))
			...


-- Luc
