From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Re: [PATCH 15/16] deal with enum members without excessive PITA
Date: Thu, 13 Dec 2007 15:21:32 +0100
Message-ID: <OFAE867B27.E1902CE8-ONC12573B0.004D30CA-C12573B0.004EE4A1@br-automation.com>
References: <E1I2N6L-0003fT-82@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:49001 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbXLMOjX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Dec 2007 09:39:23 -0500
In-Reply-To: <E1I2N6L-0003fT-82@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, linux-sparse-owner@vger.kernel.org

Hello Al,

I just saw your patch for enum members, really late, I know.

But i've got a question: If I've got the symbol for a global enum - how do 
I get from this to the symbols for the enum members?
If there is no way, I've got to loop over all symbols within global_scope, 
right?

Best regards
Thomas Schmid
