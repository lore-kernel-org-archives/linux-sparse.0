From: Randy Dunlap <rdunlap@xenotime.net>
Subject: vector_size attribute?
Date: Sun, 29 May 2011 08:57:26 -0700
Message-ID: <20110529085726.c0234647.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:49851 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751049Ab1E2P5a (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 May 2011 11:57:30 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Avi Kivity <avi@redhat.com>

Current Linux mainline generates a ton of sparse warnings like

arch/x86/include/asm/kvm_emulate.h:194:28: error: attribute 'vector_size': unknown attribute

from this source line:

typedef u32 __attribute__((vector_size(16))) sse128_t;

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
