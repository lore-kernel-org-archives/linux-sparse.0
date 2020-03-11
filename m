From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Add symantic index utility
Date: Wed, 11 Mar 2020 18:06:25 +0100
Message-ID: <20200311170625.a53orumjtoffx75t@ltop.local>
References: <20200309152509.6707-1-gladkov.alexey@gmail.com>
 <20200309223701.dbnej7esb4qp56bm@ltop.local>
 <20200310150713.GB19012@redhat.com>
 <20200311090745.GD11561@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52297 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgCKRGa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Mar 2020 13:06:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so2932482wmo.2
        for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2020 10:06:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200311090745.GD11561@kadam>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Wed, Mar 11, 2020 at 12:07:45PM +0300, Dan Carpenter wrote:
> On Tue, Mar 10, 2020 at 04:07:14PM +0100, Oleg Nesterov wrote:
> 
> This does:
> 
> 	/* Shut up warnings after an error */
> 	has_error |= ERROR_CURR_PHASE;
> 
> so we probably end up not seeing some warnings.

Yes, this is annoying, OTOH syntax errors used to cause a lot
of silly errors @ evaluation and type errors caused even more
errors or crashes at linearization or later.
Ideally we should have the equivalent of this flag but more
fine grained.

-- Luc
