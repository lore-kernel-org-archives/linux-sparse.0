From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect check for floating point type
Date: Thu, 16 Mar 2017 17:40:35 +0100
Message-ID: <20170316164034.ifxla45gqic6grau@macbook.local>
References: <CACXZuxd6DsWh7i=+ETza_AOhWTdgF9b28cwmp+3G-0GsVsBJwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36965 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbdCPQkj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 12:40:39 -0400
Received: by mail-wm0-f46.google.com with SMTP id n11so52733490wma.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 09:40:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxd6DsWh7i=+ETza_AOhWTdgF9b28cwmp+3G-0GsVsBJwQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 15, 2017 at 12:40:21AM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> The function symbol_is_fp_type() in sparse-llvm.c doesn't check if
> symbol is SYM_NODE and hence does not detect a floating point type
> correctly.

Yes, it should simply use is_float_type() instead.

-- Luc
