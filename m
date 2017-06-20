From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: use built_in_ident() instead of MK_IDENT()
Date: Tue, 20 Jun 2017 18:39:51 +0200
Message-ID: <20170620163950.gkdezvohrcz7okoo@ltop.local>
References: <20170619211454.45244-1-luc.vanoostenryck@gmail.com>
 <20170620111740.GB21354@redhat.com>
 <20170620125345.nlchvizgz5ar5yrn@ltop.local>
 <20170620160711.GA23849@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35060 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdFTQjy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 12:39:54 -0400
Received: by mail-wr0-f179.google.com with SMTP id y25so58979510wrd.2
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 09:39:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170620160711.GA23849@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-sparse@vger.kernel.org, Chris Li <sparse@chrisli.org>

On Tue, Jun 20, 2017 at 06:07:11PM +0200, Oleg Nesterov wrote:
> Hmm. Now that I git-cloned the code I understand. And I can't recall why MK_IDENT() was
> written this way, it simply doesn't look right.

It looks to me as you simply wanted to avoid doing dynamic allocation
and/or the cost of the hashing.

> Probably can be fixed but I agree, lets
> remove it.

Probably yes, but yes btter to remove it.


Thanks for your reply.

-- Luc
