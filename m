From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm should handle pointer arithmetic in op_sub similarly
 to op_add
Date: Sun, 19 Mar 2017 16:28:06 +0100
Message-ID: <20170319152806.bb5irvgczibxk5ln@macpro.local>
References: <CACXZuxdSjyC6iiqgj7tJ8AnKi4iBpsM484BEw_4HoepSOUViBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36332 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbdCSP2Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:28:25 -0400
Received: by mail-wr0-f181.google.com with SMTP id u108so78149712wrb.3
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:28:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdSjyC6iiqgj7tJ8AnKi4iBpsM484BEw_4HoepSOUViBw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 14, 2017 at 01:15:37PM +0000, Dibyendu Majumdar wrote:
> It appears that the linearised code may have op_sub instructions for
> pointer arithmetic. This needs to be handled similarly to op_add.

This is fixed in the llvm-fixes-v3 serie I submitted yesterday.

-- Luc
