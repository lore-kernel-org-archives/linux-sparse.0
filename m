From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Listing special marked symbols - attribute section
Date: Thu, 3 May 2007 11:01:51 +0200
Message-ID: <OFD5E73F1F.17F8F44A-ONC12572CF.003EC61A-C12572D0.00319C0B@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [213.33.116.3] ([213.33.116.3]:3413 "EHLO
	brsmtp01.br-automation.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752068AbXECJRH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 May 2007 05:17:07 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

i want to use sparse to put out a list of symbols, which are declared with 
__attribute__((section(<sectionname>))),
where <sectionname> maybe either ".gio" or ".lio".

E.g.:
__attribute__((__section__(".gio"))) int gInt;

In 0.3 are several extensions to parse attributes, but it seems that 
<sectionname> isn't stored anywhere.
Is it possible to get <sectionname>? 

If there is no way to get <sectionname> in the actual implementation, i 
think of an extension in struct ctype.
Any comments?
Would this be useful for someone else?

Best regards
Thomas
