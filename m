From: David Binderman <dcb314@hotmail.com>
Subject: linux-4.1-rc7 and dev versions of gcc
Date: Tue, 9 Jun 2015 07:35:58 +0000
Message-ID: <DUB128-W148850BD36B441B5C030639CBE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from dub004-omc2s17.hotmail.com ([157.55.1.156]:54454 "EHLO
	DUB004-OMC2S17.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751377AbbFIHlC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Jun 2015 03:41:02 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "sparse@chrisli.org" <sparse@chrisli.org>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

Hello there,

Recent development versions of gcc have started using the 6.0.0 version=
 number.

gcc version 6.0.0 20150607 (experimental) (GCC)=20

Linux kernel doesn't understand any gcc version numbers beyond 5.

include/linux/compiler-gcc3.h=A0=20
include/linux/compiler-gcc4.h=20
include/linux/compiler-gcc5.h

Kernel build fails because no compiler-gcc6.h file.

I have a temporary bodge to copy compiler-gcc5.h file into compiler-gcc=
6.h


Regards

David Binderman

 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
