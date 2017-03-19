From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm op_shl and op_lshr code generation issue
Date: Sun, 19 Mar 2017 01:23:30 +0100
Message-ID: <20170319002329.swb65fckzvcxvexo@macbook.local>
References: <CACXZuxd8cqkqDPbUULWx1VibiZsWi_pEULiBejKPR56KENRh=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36600 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdCSAXd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 20:23:33 -0400
Received: by mail-wr0-f176.google.com with SMTP id u108so72052394wrb.3
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 17:23:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxd8cqkqDPbUULWx1VibiZsWi_pEULiBejKPR56KENRh=w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 14, 2017 at 02:04:02PM +0000, Dibyendu Majumdar wrote:
> If the rhs is not of the same size as the lhs then LLVM rejects the
> code. A fix is to extend the rhs to match the lhs.

Submit a test case, please.

-- Luc 
