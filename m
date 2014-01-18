From: "H. Peter Anvin" <hpa@zytor.com>
Subject: cgcc: please support -iwithprefix
Date: Fri, 17 Jan 2014 16:22:22 -0800
Message-ID: <52D9C93E.80504@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36680 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbaARAWa (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 17 Jan 2014 19:22:30 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

When doing embedded work, like kernels or other nonstandard
environments, we want to exclude the standard library with -nostdinc,
but that also excludes header files intrinsic to the *compiler* such as
<stdarg.h>.

gcc uses the option -iwithprefix for that, in particular "-iwithprefix
include" adds those compiler-specific header files back into the include
path.  cgcc doesn't seem to understand that and instead interprets the
option argument as an additional file.

It is unsual in gcc for an option argument to be separate, but it isn't
unique:

        -idirafter DIR
        -include FILE  -imacros FILE
        -iprefix FILE  -iwithprefix DIR
        -iwithprefixbefore DIR  -isystem DIR
        -imultilib DIR -isysroot DIR
	-Xpreprocessor OPTION
	-Xassembler OPTION
	-T SCRIPT
	-Xlinker OPTION
