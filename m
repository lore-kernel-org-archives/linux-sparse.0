From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] fix expansion of integers to floats
Date: Sat, 1 Apr 2017 12:45:02 +0200
Message-ID: <20170401104501.dva6nm2xr7hu7s6l@macpro.local>
References: <20170327143403.62903-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34858 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbdDAKpG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Apr 2017 06:45:06 -0400
Received: by mail-wm0-f46.google.com with SMTP id y22so14751767wmh.0
        for <linux-sparse@vger.kernel.org>; Sat, 01 Apr 2017 03:45:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170327143403.62903-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

This patch and another bugfix floating-point related  are available at:
	git://github.com/lucvoo/sparse.git float-expand-v2
based on commit:
	c1a53a868ebafd1d134e4a77c86074b9d07e4281 (fix-32bit-tests)
up to commit:
	5c9411a5c0482b0ceb70861114df4c229e1298ca


-- Luc Van Oostenryck
