From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 06:21:25 +0100
Message-ID: <20170302052124.fsqogvysufayy4to@macbook.local>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local>
 <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:32856 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754230AbdCBJYf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 04:24:35 -0500
Received: by mail-wr0-f170.google.com with SMTP id u48so47558070wrc.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 01:24:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 01, 2017 at 02:45:03PM +0000, Dibyendu Majumdar wrote:
> On 1 March 2017 at 10:58, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> > On 28 February 2017 at 17:03, Luc Van Oostenryck
> > <luc.vanoostenryck@gmail.com> wrote:
> >> On Tue, Feb 28, 2017 at 4:09 PM, Luc Van Oostenryck
> >> <luc.vanoostenryck@gmail.com> wrote:
> >>> There is indeed some problems regarding this, we looked a bit at this
> >>> some weeks ago. However I firmly believe that the information about
> >>> the type belong to the operations and not the values.
> >>
> >
> > I am trying to work out how a value pseudo correct type can be
> > determined when the pseudo is a function call argument. Would
> > appreciate any pointers on this. The current implementation of
> > pseudo_to_value() uses the function call instruction which is
> > incorrect.
> >
> 
> I have implemented a solution that get the type information from the
> function prototype for pseudo values when processing function
> arguments, but not sure this is correct.

You need something like:
+struct symbol *argument_type(pseudo_t src)
+{
+	struct entrypoint *ep = src->def->bb->ep;
+	struct symbol_list *args = ep->name->ctype.base_type->arguments;
+	struct symbol *arg;
+	int i = 0;
+	FOR_EACH_PTR(args, arg) {
+		if (++i == src->nr)
+			return arg;
+	} END_FOR_EACH_PTR(arg);
+
+	assert(0);
+}
 
> Anyway have hit a bunch of other issues with sparse-llvm ... :-(

Each day its problem (and happily its solution too!).


Luc
