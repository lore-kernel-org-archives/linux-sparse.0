From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Initializing float variables without type suffix
Date: Wed, 4 Feb 2009 15:57:59 +0100
Message-ID: <OFC65EA87B.BAADFE01-ONC1257553.004CCDB9-C1257553.00522B4E@br-automation.com>
References: <1216938210.5455.16.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:47663 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbZBDPRy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2009 10:17:54 -0500
In-Reply-To: <1216938210.5455.16.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org

Hello,

i think i found an error, when float variables are initialized.
Parsing the line

float var = 1.2345; 

creates a symbol "var", but the initializer (struct expression) is from 
type "EXPR_VALUE" - 
not "EXPR_FVALUE".
I think this happens, because the expression "1.2345" is interpreted as 
double and, as result of this, 
gets casted with the function cast_to(). It seems that cast_to() doesn't 
make double to float casts.

The result of this is, that if you want to show the initvalue of this 
symbol, "1" instead of "1.2345" is displayed.
If the variable is initialized with an additional type suffix, like 

float var = 1.2345F; 

or datatype double is used, it works.

Greetings,
Thomas Schmid


