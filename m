From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Add symantic index utility
Date: Wed, 11 Mar 2020 17:47:42 +0100
Message-ID: <20200311164742.3jjzixpsb34pwgfo@ltop.local>
References: <20200309152509.6707-1-gladkov.alexey@gmail.com>
 <20200309223701.dbnej7esb4qp56bm@ltop.local>
 <20200310150713.GB19012@redhat.com>
 <20200310171202.y5rhsydmmbewoarm@ltop.local>
 <20200311120427.GB19327@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45878 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgCKQrp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Mar 2020 12:47:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id m9so3505171wro.12
        for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2020 09:47:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200311120427.GB19327@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Wed, Mar 11, 2020 at 01:04:27PM +0100, Oleg Nesterov wrote:
> On 03/10, Luc Van Oostenryck wrote:
> >
> > Anyway, only a warning should be issued (I'll send a patch for this).
> > I also wouldn't mind to add a new warning flag to suppress it,
> > something like -Wno-directive-within-macro.
> 
> OK, agreed. something like below?

Yes, perfect.

-- Luc
