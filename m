From: Johannes Berg <johannes@sipsolutions.net>
Subject: cannot size expression - exported array in kernel
Date: Mon, 21 Nov 2011 11:06:57 +0100
Message-ID: <1321870017.3999.31.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:42159 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619Ab1KUKHB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Nov 2011 05:07:01 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.77)
	(envelope-from <johannes@sipsolutions.net>)
	id 1RSQmC-0003KK-FR
	for linux-sparse@vger.kernel.org; Mon, 21 Nov 2011 11:07:00 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Here's some code from net/wireless/util.c, expressed as a test case. I
have no idea how to fix it. The actual output is:

+sizeof-external.c:11:16: error: cannot size expression

while none is expected.

johannes

/***** begin file validation/sizeof-external.c **** */
/* #include file that declares it */
extern const unsigned char bridge_tunnel_header[6];

/* define it */
const unsigned char bridge_tunnel_header[] = { 1, 2, 3, 4, 5, 6 };
/* EXPORT_SYMBOL it */
extern typeof(bridge_tunnel_header) bridge_tunnel_header; /* ... */

static int bth_size(void)
{
	return sizeof(bridge_tunnel_header);
}

/*
 * check-name: Check sizeof(kernel_exported_external_variable)
 *
 * check-error-start
 * check-error-end
 */


