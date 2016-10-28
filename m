From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3] sparse: add support for static assert
Date: Fri, 28 Oct 2016 22:38:13 +0200
Message-ID: <20161028203812.GA2221@macbook.local>
References: <1454989031-12240-1-git-send-email-lrichard@redhat.com>
 <20160315225203.GC2679@macpro.local>
 <481469876.53571906.1465915752753.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36246 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756124AbcJ1UiR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 28 Oct 2016 16:38:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id c17so8924726wmc.3
        for <linux-sparse@vger.kernel.org>; Fri, 28 Oct 2016 13:38:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <481469876.53571906.1465915752753.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Jun 14, 2016 at 10:49:12AM -0400, Lance Richardson wrote:
> ----- Original Message -----
> > From: "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
> > To: "Lance Richardson" <lrichard@redhat.com>
> > Cc: linux-sparse@vger.kernel.org
> > Sent: Tuesday, March 15, 2016 6:52:03 PM
> > Subject: Re: [PATCH v3] sparse: add support for static assert
> > 
> > On Mon, Feb 08, 2016 at 10:37:10PM -0500, Lance Richardson wrote:
> > > This patch introduces support for _Static_assert() in global,
> > > function, and struct/union declaration contexts (as currently supported
> > > by gcc).
> > > 
> > > Tested via:
> > >    - kernel build with C=1 CF=-D__CHECK_ENDIAN__
> > >    - build/check large code base making heavy use of _Static_assert()
> > >    - "make check" with added test cases for static assert support
> > > 
> > > Signed-off-by: Lance Richardson <lrichard@redhat.com>
> > 
> > 
> > Fine for me.
> > 
> > Feel free to add
> >   Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > 
> > 
> > Chris, I have already reviwed this in January and Richard have taken
> > my remarks in account.
> > Do you think you you will have some time soon to look at it?
> > 
> > 
> > Regards,
> > Luc
> > 
> 
> Dusting this one off... "ping"?
> 
> Thanks and Regards,
> 
>    Lance

Chris, is is possible to have some feedback on this serie, please?

Is there anything more I can do to help?


Best regards,
Luc
