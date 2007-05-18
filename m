From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Differences in the behaviour of sparse and gcc within cygwin environment
Date: Fri, 18 May 2007 13:43:11 +0200
Message-ID: <OFD0819B39.CB485382-ONC12572DF.003FFDE5-C12572DF.004060F0@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.br-automation.com ([213.33.116.60]:37371 "EHLO
	mail1.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbXERLne (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 May 2007 07:43:34 -0400
Received: from brsmtp01.br-automation.com (unknown [192.168.1.60])
	by mail1.br-automation.com (Symantec Mail Security) with ESMTP id F0BDC4E4002
	for <linux-sparse@vger.kernel.org>; Fri, 18 May 2007 13:43:16 +0200 (CEST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I use sparse in a cygwin environment to obtain pre-build info from 
sourcefiles which get comiled with gcc (also compiled with cygwin).

After some time of using sparse, I noticed some differences in the 
behaviour of sparse and gcc:
1. Symbolnames with "$" are accepted by gcc but not by sparse
2. #include "..\plc.h" is accepted by gcc but not by sparse => "\" is 
interpreted as escape- character
3. #include "D:\plc.h" is accepted by gcc but not by sparse

I know that number 2 and 3 are problems which only occur within an cygwin 
environment and number 3 isn't the best way to include files,
but is there any chance to get this fixed?


Best regards,
Thomas Schmid
