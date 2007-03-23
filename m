From: Randy Dunlap <rdunlap@xenotime.net>
Subject: more spewage (Re: sparse segfault on ppc64)
Date: Fri, 23 Mar 2007 15:04:59 -0700
Message-ID: <20070323150459.52b02342.rdunlap@xenotime.net>
References: <20070322063600.GD15364@redhat.com>
	<20070322073344.GU4095@ftp.linux.org.uk>
	<20070322070354.GA22151@chrisli.org>
	<20070322171118.GL15364@redhat.com>
	<20070322221050.GC22151@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:52840 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992587AbXCWWEB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2007 18:04:01 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Fri, 23 Mar 2007 15:03:59 -0700
In-Reply-To: <20070322221050.GC22151@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Thu, 22 Mar 2007 15:10:51 -0700 Christopher Li wrote:

> On Thu, Mar 22, 2007 at 01:11:18PM -0400, Dave Jones wrote:
> > So the good news is that this only seems to affect 0.2
> > Current git doesn't segfault, but still emits lots of spew.
> > 
> > 	Dave
> > 
> > /usr/lib/gcc/powerpc64-linux/4.0.1/include/altivec.h:36:2: error: Use the "-maltivec" flag to enable PowerPC AltiVec support
> > drivers/md/raid6altivec1.c:41:16: error: Expected ; at end of declaration
> > drivers/md/raid6altivec1.c:41:16: error: got signed
> 
> The spew is cause by the vector extension which sparse know nothing about.
> It is kind of expected.

There are also sparse error spewings on attributes((...)) that are
not in the expected source code location.  Three examples:


1.  net/sched/cls_api.c, lines 593-611:

	return 0;
rtattr_failure: __attribute__ ((unused))
	return -1;
}

...

	return 0;
rtattr_failure: __attribute__ ((unused))
	return -1;
}

These spew:

net/sched/cls_api.c:593:17: error: typename in expression
net/sched/cls_api.c:594:2: error: Expected ; at end of statement
net/sched/cls_api.c:594:2: error: got return
net/sched/cls_api.c:611:17: error: typename in expression
net/sched/cls_api.c:612:2: error: Expected ; at end of statement
net/sched/cls_api.c:612:2: error: got return
net/sched/cls_api.c:593:17: error: undefined identifier '__attribute__'
net/sched/cls_api.c:611:17: error: undefined identifier '__attribute__'


2.  in 2.6.21-rc4-mm1 only AFAIK, arch/x86_64/kernel/early-quirks.c, #79:

static struct __initdata chipset early_qrk[] = {
	{ PCI_VENDOR_ID_NVIDIA, nvidia_bugs },
	{ PCI_VENDOR_ID_VIA, via_bugs },
	{ PCI_VENDOR_ID_ATI, ati_bugs },
	{}
};

spews:

arch/x86_64/kernel/early-quirks.c:79:15: error: Trying to use reserved word '__attribute__' as identifier
arch/x86_64/kernel/early-quirks.c:79:15: error: Expected ) in function declarator
arch/x86_64/kernel/early-quirks.c:79:15: error: got ".init.data"


3.  drivers/kvm/ spews LOTS of mess:

drivers/kvm/svm.h:50:8: error: Trying to use reserved word '__attribute__' as identifier
drivers/kvm/svm.h:50:37: error: Expected ; at end of declaration
drivers/kvm/svm.h:50:37: error: got vmcb_control_area
drivers/kvm/svm.h:81:1: error: Expected ; end of type declaration
drivers/kvm/svm.h:81:1: error: got }
drivers/kvm/svm.h:114:8: error: Trying to use reserved word '__attribute__' as identifier
drivers/kvm/svm.h:114:37: error: Expected ; at end of declaration
drivers/kvm/svm.h:114:37: error: got vmcb_seg
drivers/kvm/svm.h:119:1: error: Expected ; end of type declaration
drivers/kvm/svm.h:119:1: error: got }
drivers/kvm/svm.h:121:8: error: Trying to use reserved word '__attribute__' as identifier
drivers/kvm/svm.h:121:37: error: Expected ; at end of declaration
drivers/kvm/svm.h:121:37: error: got vmcb_save_area
drivers/kvm/svm.h:164:1: error: Expected ; end of type declaration
drivers/kvm/svm.h:164:1: error: got }
drivers/kvm/svm.h:166:8: error: Trying to use reserved word '__attribute__' as identifier
drivers/kvm/svm.h:166:37: error: Expected ; at end of declaration
drivers/kvm/svm.h:166:37: error: got vmcb
drivers/kvm/svm.h:169:1: error: Expected ; end of type declaration
drivers/kvm/svm.h:169:1: error: got }
drivers/kvm/svm.c:87:46: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:90:10: error: no member 'cr0' in struct vmcb_save_area
drivers/kvm/svm.c:93:16: error: no member 'cs' in struct vmcb_save_area
drivers/kvm/svm.c:186:17: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:192:17: error: no member 'control' in struct vmcb
drivers/kvm/svm.c:196:17: error: no member 'control' in struct vmcb
drivers/kvm/svm.c:201:17: error: no member 'control' in struct vmcb
drivers/kvm/svm.c:208:17: error: no member 'control' in struct vmcb
drivers/kvm/svm.c:231:43: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:234:25: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:238:29: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:239:17: error: no member 'control' in struct vmcb
drivers/kvm/svm.c:438:5: error: no member 'selector' in struct vmcb_seg
drivers/kvm/svm.c:439:5: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:441:5: error: no member 'limit' in struct vmcb_seg
drivers/kvm/svm.c:442:5: error: no member 'base' in struct vmcb_seg
drivers/kvm/svm.c:447:5: error: no member 'selector' in struct vmcb_seg
drivers/kvm/svm.c:448:5: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:449:5: error: no member 'limit' in struct vmcb_seg
drivers/kvm/svm.c:450:5: error: no member 'base' in struct vmcb_seg
drivers/kvm/svm.c:460:43: error: no member 'control' in struct vmcb
drivers/kvm/svm.c:461:37: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:464:9: error: no member 'intercept_cr_read' in struct vmcb_control_area
drivers/kvm/svm.c:468:9: error: no member 'intercept_cr_write' in struct vmcb_control_area
drivers/kvm/svm.c:472:9: error: no member 'intercept_dr_read' in struct vmcb_control_area
drivers/kvm/svm.c:477:9: error: no member 'intercept_dr_write' in struct vmcb_control_area
drivers/kvm/svm.c:484:9: error: no member 'intercept_exceptions' in struct vmcb_control_area
drivers/kvm/svm.c:487:9: error: no member 'intercept' in struct vmcb_control_area
drivers/kvm/svm.c:516:9: error: no member 'iopm_base_pa' in struct vmcb_control_area
drivers/kvm/svm.c:517:9: error: no member 'msrpm_base_pa' in struct vmcb_control_area
drivers/kvm/svm.c:519:9: error: no member 'tsc_offset' in struct vmcb_control_area
drivers/kvm/svm.c:520:9: error: no member 'int_ctl' in struct vmcb_control_area
drivers/kvm/svm.c:522:16: error: no member 'es' in struct vmcb_save_area
drivers/kvm/svm.c:523:16: error: no member 'ss' in struct vmcb_save_area
drivers/kvm/svm.c:524:16: error: no member 'ds' in struct vmcb_save_area
drivers/kvm/svm.c:525:16: error: no member 'fs' in struct vmcb_save_area
drivers/kvm/svm.c:526:16: error: no member 'gs' in struct vmcb_save_area
drivers/kvm/svm.c:528:6: error: no member 'cs' in struct vmcb_save_area
drivers/kvm/svm.c:530:6: error: no member 'cs' in struct vmcb_save_area
drivers/kvm/svm.c:532:6: error: no member 'cs' in struct vmcb_save_area
drivers/kvm/svm.c:539:6: error: no member 'cs' in struct vmcb_save_area
drivers/kvm/svm.c:541:6: error: no member 'gdtr' in struct vmcb_save_area
drivers/kvm/svm.c:542:6: error: no member 'idtr' in struct vmcb_save_area
drivers/kvm/svm.c:544:20: error: no member 'ldtr' in struct vmcb_save_area
drivers/kvm/svm.c:545:20: error: no member 'tr' in struct vmcb_save_area
drivers/kvm/svm.c:547:6: error: no member 'efer' in struct vmcb_save_area
drivers/kvm/svm.c:549:13: error: no member 'dr6' in struct vmcb_save_area
drivers/kvm/svm.c:550:6: error: no member 'dr7' in struct vmcb_save_area
drivers/kvm/svm.c:551:6: error: no member 'rflags' in struct vmcb_save_area
drivers/kvm/svm.c:552:6: error: no member 'rip' in struct vmcb_save_area
drivers/kvm/svm.c:558:6: error: no member 'cr0' in struct vmcb_save_area
drivers/kvm/svm.c:559:6: error: no member 'cr4' in struct vmcb_save_area
drivers/kvm/svm.c:619:45: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:620:45: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:621:29: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:626:17: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:627:17: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:628:17: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:633:24: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:638:17: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:643:48: error: no member 'save' in struct vmcb
drivers/kvm/svm.c:646:33: error: no member 'cs' in struct vmcb_save_area
drivers/kvm/svm.c:647:33: error: no member 'ds' in struct vmcb_save_area
drivers/kvm/svm.c:648:33: error: no member 'es' in struct vmcb_save_area
drivers/kvm/svm.c:649:33: error: no member 'fs' in struct vmcb_save_area
drivers/kvm/svm.c:650:33: error: no member 'gs' in struct vmcb_save_area
drivers/kvm/svm.c:651:33: error: no member 'ss' in struct vmcb_save_area
drivers/kvm/svm.c:652:33: error: no member 'tr' in struct vmcb_save_area
drivers/kvm/svm.c:653:35: error: no member 'ldtr' in struct vmcb_save_area
drivers/kvm/svm.c:663:10: error: no member 'base' in struct vmcb_seg
drivers/kvm/svm.c:671:15: error: no member 'base' in struct vmcb_seg
drivers/kvm/svm.c:672:16: error: no member 'limit' in struct vmcb_seg
drivers/kvm/svm.c:673:19: error: no member 'selector' in struct vmcb_seg
drivers/kvm/svm.c:674:15: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:675:13: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:676:15: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:677:19: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:678:15: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:679:13: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:680:14: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:681:13: error: no member 'attrib' in struct vmcb_seg
drivers/kvm/svm.c:689:10: error: too many errors
drivers/kvm/kvm_main.c:590:9: error: Trying to use reserved word '__attribute__' as identifier
drivers/kvm/kvm_main.c:590:38: error: Expected ; at end of declaration
drivers/kvm/kvm_main.c:590:38: error: got fx_image_s
drivers/kvm/kvm_main.c:602:14: error: Expected ) in function declarator
drivers/kvm/kvm_main.c:602:14: error: got ->
drivers/kvm/kvm_main.c:604:14: error: Expected ) in function declarator
drivers/kvm/kvm_main.c:604:14: error: got ->
drivers/kvm/kvm_main.c:605:17: error: Expected ) in function declarator
drivers/kvm/kvm_main.c:605:17: error: got ->
drivers/kvm/kvm_main.c:608:10: error: Expected ; at end of declaration
drivers/kvm/kvm_main.c:608:10: error: got ->
drivers/kvm/kvm_main.c:609:2: error: Expected ) in function declarator
drivers/kvm/kvm_main.c:609:2: error: got 0
drivers/kvm/kvm_main.c:611:1: error: Expected ; end of type declaration
drivers/kvm/kvm_main.c:611:1: error: got }
drivers/kvm/kvm_main.c:607:34: error: undefined identifier 'vcpu'
drivers/kvm/kvm_main.c:607:2: error: symbol 'fx_image' redeclared with different type (originally declared at drivers/kvm/kvm_main.c:600) - different base types
drivers/kvm/kvm_main.c:608:2: error: symbol 'fx_image' redeclared with different type (originally declared at drivers/kvm/kvm_main.c:600) - different base types



---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
