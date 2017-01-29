From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: status of sparse-next
Date: Sun, 29 Jan 2017 12:04:09 +0100
Message-ID: <20170129110408.plroh36zakyh5uay@macbook.local>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37745 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdA2LbA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 06:31:00 -0500
Received: by mail-wm0-f42.google.com with SMTP id v77so8528754wmv.0
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 03:30:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

I've tested reatively extensively the current sparse-next.
There was a crash problem triggered by one of my patches and
two others minors problems, all three addressed by this serie.

With this changes, sparse-next behave correctly on:
- the testsuite
- using sparse on an allyesconfig of the kernel on x86
- no crashes on the GCC testsuite (where sparse or test-linearizes
  make sense).
- my collection of test files (200+ files but consisting mainly
  of simple cases concerning linearization).


Luc
