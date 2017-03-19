From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm the LLVM IR for select instruction fails due to
 different types
Date: Sun, 19 Mar 2017 01:21:46 +0100
Message-ID: <20170319002145.4x3amj6bnb36yocj@macbook.local>
References: <CACXZuxcGKmEbv=Umh26U=Uermy+n1f2A9_ZmBYJHE15WBYPFrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33107 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdCSAxH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 20:53:07 -0400
Received: by mail-wr0-f172.google.com with SMTP id u48so72254732wrc.0
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 17:53:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcGKmEbv=Umh26U=Uermy+n1f2A9_ZmBYJHE15WBYPFrw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 14, 2017 at 04:07:40PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> LLVM complains when the operands of a select are not the same type. I
> think it is okay to cast one of the operands to the type of the other
> - on the basis that subsequent operations will cast things anyway.

Submit a test case, please.

-- Luc 
