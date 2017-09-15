From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] compile-i386: make use of expression_list_size()
Date: Fri, 15 Sep 2017 09:46:02 +0200
Message-ID: <20170915074601.xeux2zlvhwbzyhhn@ltop.local>
References: <20170915070219.29239-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37631 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdIOHqF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:46:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so2016873wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:46:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170915070219.29239-1-martink@posteo.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: sparse@chrisli.org, jgarzik@pobox.com, linux-sparse@vger.kernel.org

On Fri, Sep 15, 2017 at 09:02:19AM +0200, Martin Kepplinger wrote:
> Instead of doing it my hand, there is the expression_list_size() API we
> can use here.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
