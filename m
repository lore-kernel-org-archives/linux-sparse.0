From: Emil Langrock <emil.langrock@gmx.de>
Subject: Missing bitwise warnings
Date: Sun, 5 Jun 2011 01:50:45 +0200
Message-ID: <201106050150.46039.emil.langrock@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:34091 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754307Ab1FDXus (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 4 Jun 2011 19:50:48 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I am currently trying to use sparse and found the interesting looking
-Wbitwise. I pasted the sum code from 
http://www.gelato.unsw.edu.au/IA64wiki/SparseAnnotations to check how that 
warning looks like, but are unable to create that warning. I added this code 
to random places in the kernel (2.6.39) and compiled it with
`make CC="cgcc -Wbitwise"`.

My sparse version is v0.4.3-13-g87f4a7f
-- 
Emil Langrock
