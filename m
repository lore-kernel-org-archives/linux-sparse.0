From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] Handle SForced in storage_modifiers
Date: Thu, 17 Nov 2016 07:43:57 -0500
Message-ID: <1479386637.2527.0.camel@redhat.com>
References: <1479150736-28392-1-git-send-email-jlayton@redhat.com>
         <20161114200447.GA15866@macbook.local>
         <CA+55aFxbn+ZAyN9zzcEF60UPoRN2hq86LHk9v5ecqg-c+x3pNw@mail.gmail.com>
         <CANeU7Q=p=kcHCZ2uupc+7e_Gg5uYpe2b2aoS+8nAwyK+jxLtqw@mail.gmail.com>
         <1479175640.7928.1.camel@redhat.com>
         <CANeU7Qn_hebujogeF-HEaDsSWbEaPJTDpSUR5bXG1t1r7MihXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34359 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752897AbcKQOcO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 09:32:14 -0500
Received: by mail-qk0-f174.google.com with SMTP id q130so221995348qke.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 06:32:13 -0800 (PST)
In-Reply-To: <CANeU7Qn_hebujogeF-HEaDsSWbEaPJTDpSUR5bXG1t1r7MihXA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>

On Thu, 2016-11-17 at 06:28 +0800, Christopher Li wrote:
> On Tue, Nov 15, 2016 at 10:07 AM, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > 
> > That looks fine to me. If you want to merge that one, then:
> > 
> > Reviewed-by: Jeff Layton <jlayton@redhat.com>
> 
> The patches is applied on "chrisl" repo and pushed out.
> 
> Actually I want to merge the patch having you as the author.
> 
> Chris

Looks good to me. Thanks!
-- 
Jeff Layton <jlayton@redhat.com>
