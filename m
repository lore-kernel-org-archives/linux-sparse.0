From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] Add semantic index utility
Date: Wed, 11 Mar 2020 22:56:23 +0100
Message-ID: <20200311215623.dafdzmub25dlb7za@ltop.local>
References: <20200311172246.59838-1-gladkov.alexey@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38547 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbgCKV42 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Mar 2020 17:56:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id h83so397504wmf.3
        for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2020 14:56:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200311172246.59838-1-gladkov.alexey@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>

On Wed, Mar 11, 2020 at 06:22:46PM +0100, Alexey Gladkov wrote:
> sindex is the simple to use cscope-like tool based on sparse/dissect.
> Unlike cscope it runs after pre-processor and thus it can't index the
> code filtered out by ifdef's, but otoh it understands how the symbol
> is used and it can track the usage of struct members.

Great! Thank you.

I've pushed this with 2 small changes:
1) a bunch of s/0/NULL/ to quiet make selfcheck
2) s/st.st_mtim.tv_sec/st.st_mtime/ or comptability.

-- Luc
