From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Behaviour of attribute "context" changed, sparse 0.3 vs. 0.4(.1)
Date: Fri, 11 Jan 2008 12:09:56 +0100
Message-ID: <OFDC7A2858.F24630BB-ONC12573CD.003D4A83-C12573CD.003D55EE@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:39183 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbYAKLKA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Jan 2008 06:10:00 -0500
Received: from brsmtp01.br-automation.com (unknown [192.168.1.60])
	by mail2.br-automation.com (Symantec Mail Security) with ESMTP id EEC9C4DC002
	for <linux-sparse@vger.kernel.org>; Fri, 11 Jan 2008 12:09:57 +0100 (CET)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello,

the declaration 
int nArr1[5] __attribute__((context(0,1,2)));
parsed with sparse 0.3 results in a symbol with one context in 
symbol->ctype.contexts and symbol->ctype.base_type->ctype.contexts is 
empty.

If we do the same with sparse 0.4 (or also 0.4.1), we get a symbol with 
one context in symbol->ctype.contexts, 
but now  symbol->ctype.base_type->ctype.contexts also has the same 
context.

Perhaps interesting: The result of declaration 
int __attribute__((context(0,1,2))) nArr2[5];
didn't change.

Is this behaviour OK?
Is this behaviour expected? 

Greetings
Thomas Schmid
