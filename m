From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: struct/union attributes placement
Date: Wed, 29 Nov 2006 11:07:18 -0800
Message-ID: <20061129110718.f08e0ed3.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:46948 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S967535AbWK2TGv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Nov 2006 14:06:51 -0500
Received: from rgmgw3.us.oracle.com (rgmgw3.us.oracle.com [138.1.186.112])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id kATJ6nv0023205
	for <linux-sparse@vger.kernel.org>; Wed, 29 Nov 2006 13:06:49 -0600
Received: from midway.site (dhcp-amer-csvpn-gw1-141-144-64-8.vpn.oracle.com [141.144.64.8])
	by rgmgw3.us.oracle.com (Switch-3.2.4/Switch-3.1.7) with SMTP id kATJ6mCS004022
	for <linux-sparse@vger.kernel.org>; Wed, 29 Nov 2006 12:06:48 -0700
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

In 2.6.19-rc6-mm2, kvm places struct attributes between
"struct" and the struct name (in drivers/kvm/kvm_main.c):

void fx_init(struct kvm_vcpu *vcpu)
{
	struct __attribute__ ((__packed__)) fx_image_s {
		u16 control; //fcw
		u16 status; //fsw
		u16 tag; // ftw
		u16 opcode; //fop
		u64 ip; // fpu ip
		u64 operand;// fpu dp
		u32 mxcsr;
		u32 mxcsr_mask;

	} *fx_image;

This is legal gcc according to
http://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Type-Attributes.html#Type-Attributes

but sparse complains about it (and following usage statements):

drivers/kvm/kvm_main.c:473:9: error: Trying to use reserved word '__attribute__' as identifier
drivers/kvm/kvm_main.c:473:38: error: Expected ; at end of declaration
drivers/kvm/kvm_main.c:473:38: error: got fx_image_s
drivers/kvm/kvm_main.c:485:14: error: Expected ) in function declarator
drivers/kvm/kvm_main.c:485:14: error: got ->
drivers/kvm/kvm_main.c:487:14: error: Expected ) in function declarator
drivers/kvm/kvm_main.c:487:14: error: got ->
drivers/kvm/kvm_main.c:488:17: error: Expected ) in function declarator
drivers/kvm/kvm_main.c:488:17: error: got ->
drivers/kvm/kvm_main.c:491:10: error: Expected ; at end of declaration
drivers/kvm/kvm_main.c:491:10: error: got ->
drivers/kvm/kvm_main.c:492:13: error: Expected ) in function declarator
drivers/kvm/kvm_main.c:492:13: error: got ->
drivers/kvm/kvm_main.c:494:1: error: Expected ; end of type declaration
drivers/kvm/kvm_main.c:494:1: error: got }
drivers/kvm/kvm_main.c:490:2: error: symbol 'fx_image' redeclared with different type (originally declared at drivers/kvm/kvm_main.c:483) - different base types
drivers/kvm/kvm_main.c:491:2: error: symbol 'fx_image' redeclared with different type (originally declared at drivers/kvm/kvm_main.c:483) - different base types

---
~Randy
