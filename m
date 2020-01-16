From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] show_parse: avoid null pointer dereference in
 do_show_type()
Date: Thu, 16 Jan 2020 20:26:32 +0100
Message-ID: <20200116192632.niymcq4xv2wgnix4@ltop.local>
References: <20200116174838.GA32100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45920 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgAPT0i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Jan 2020 14:26:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so20324268wrj.12
        for <linux-sparse@vger.kernel.org>; Thu, 16 Jan 2020 11:26:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200116174838.GA32100@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Thu, Jan 16, 2020 at 06:48:38PM +0100, Oleg Nesterov wrote:
> do_show_type() checks sym->type inside the "if (!sym || ...)" block.
> 
> While at it, remove the trailing whitespaces.

Thank you! Applied and pushed. 

-- Luc
