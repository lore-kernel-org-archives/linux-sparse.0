From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect check for floating point type
Date: Sun, 19 Mar 2017 16:26:07 +0100
Message-ID: <20170319152606.4h7ljv4w3xaiaebw@macpro.local>
References: <CACXZuxd6DsWh7i=+ETza_AOhWTdgF9b28cwmp+3G-0GsVsBJwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34774 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbdCSP1L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:27:11 -0400
Received: by mail-wr0-f172.google.com with SMTP id l37so78312978wrc.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:26:10 -0700 (PDT)
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

This is fixed in the llvm-fixes-v3 serie I sent yesterday.

-- Luc 
