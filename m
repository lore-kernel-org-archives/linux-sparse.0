From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: sparse: new feature " multiple initializers" has false positives
 on MODULE_ALIAS
Date: Thu, 22 Jan 2015 21:31:10 +0100
Message-ID: <54C15E0E.4000008@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:41218 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbbAVUbP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Jan 2015 15:31:15 -0500
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Thu, 22 Jan 2015 20:31:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C02BD219005C
	for <linux-sparse@vger.kernel.org>; Thu, 22 Jan 2015 20:31:09 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0MKVBC557278608
	for <linux-sparse@vger.kernel.org>; Thu, 22 Jan 2015 20:31:11 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0MKVA5V018181
	for <linux-sparse@vger.kernel.org>; Thu, 22 Jan 2015 13:31:11 -0700
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>
Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org

Linus, Christopher,

Commit  0f25c6a78e08fdc15af5e599d836fa24349c042f ("Add warning about duplicate initializers") has a false positive on arch/s390/kvm/kvm-s390.c

  CHECK   arch/s390/kvm/kvm-s390.c
arch/s390/kvm/kvm-s390.c:1823:1: error: symbol '__UNIQUE_ID_alias__COUNTER__' has multiple initializers (originally initialized at arch/s390/kvm/kvm-s390.c:1822)

1822: MODULE_ALIAS_MISCDEV(KVM_MINOR);
1823: MODULE_ALIAS("devname:kvm");


Preprocessing with gcc gives
static const char __UNIQUE_ID_alias0[] __attribute__((__used__)) __attribute__((section(".modinfo"), unused, aligned(1))) = "alias" "=" "char-major-" "10" "-" "232";
static const char __UNIQUE_ID_alias1[] __attribute__((__used__)) __attribute__((section(".modinfo"), unused, aligned(1))) = "alias" "=" "devname:kvm";

so alias0 and alias1 instead of __COUNTER__.
I never heard of __COUNTER__ before, so I guess its some gcc magic that sparse should mimic..

Christian

