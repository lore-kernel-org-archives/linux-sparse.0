From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm when generating code for op_muls, op_divs first
 argument may be a pointer
Date: Sun, 19 Mar 2017 16:27:44 +0100
Message-ID: <20170319152743.vyapkk5234dyeq3o@macpro.local>
References: <CACXZuxekhPX=9UGiBkboZ2viBpY4gftUC4v9xuCmOKvsU7QoHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36267 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbdCSP2Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:28:25 -0400
Received: by mail-wr0-f178.google.com with SMTP id u108so78146396wrb.3
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:27:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxekhPX=9UGiBkboZ2viBpY4gftUC4v9xuCmOKvsU7QoHQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 14, 2017 at 01:14:20PM +0000, Dibyendu Majumdar wrote:
> Sparse-llvm currently generates incorrect code for op_muls and op_divs
> when the first argument is a pointer. In this case the pointer should
> be converted to integer before multiplying or dividing.

This is fixed in the llvm-fixes-v3 serie I submitted yesterday.

-- Luc
