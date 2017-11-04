From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [SPARSE] Questions for distros
Date: Sat, 04 Nov 2017 13:43:29 -0400
Message-ID: <1509817409.29302.14.camel@redhat.com>
References: <20171104172528.35tzbeh4k6kp6bbg@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:46309 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdKDRnb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Nov 2017 13:43:31 -0400
Received: by mail-qk0-f178.google.com with SMTP id k123so6700629qke.3
        for <linux-sparse@vger.kernel.org>; Sat, 04 Nov 2017 10:43:31 -0700 (PDT)
In-Reply-To: <20171104172528.35tzbeh4k6kp6bbg@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Sat, 2017-11-04 at 18:25 +0100, Luc Van Oostenryck wrote:
> Hi,
> 
> I'm making some cleanup in my dev tree and there are a few things
> I'm curious about concerning what distros are doing.
> 
> I hope you don't mind to answer to those questions.
> 
> 1) Do the distros use sparse's shared lib?
>    I remember there was a mail about it months ago but 
>    I can't find it anymore.
> 

The Fedora and EPEL packages do not. I'm not opposed to adding it, but I
don't really need it and no one has asked for it.

> 2) Do the distros use sparse's install rule?
> 

Yes. rpmbuild basically does a make install in a chrooted dir, and then
installs the files that end up in there.

> 3) Do the distros install sparse with its pkconfig?

No. Since we aren't packaging the shared lib, we don't bother.
-- 
Jeff Layton <jlayton@redhat.com>
