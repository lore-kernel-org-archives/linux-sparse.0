From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [tip:locking/kcsan 12/12] /bin/bash: line 1: 61526 Segmentation
 fault  sparse ...
Date: Thu, 28 May 2020 17:22:18 +0200
Message-ID: <20200528152218.npq53zode7hh7qh4@ltop.local>
References: <202005280727.lXn1VnTw%lkp@intel.com>
 <20200527235442.GC1805@zn.tnic>
 <20200528075900.GA236442@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404237AbgE1PWX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 May 2020 11:22:23 -0400
Content-Disposition: inline
In-Reply-To: <20200528075900.GA236442@google.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: Borislav Petkov <bp@suse.de>, kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-sparse@vger.kernel.org, arnd@arndb.de, will@kernel.org, Peter Zijlstra <peterz@infradead.org>

On Thu, May 28, 2020 at 09:59:00AM +0200, Marco Elver wrote:
> 
> Ouch. The below should be all we need, assuming it's the best we can do
> for sparse right now.

Upstream sparse should be OK with it now.

-- Luc 
