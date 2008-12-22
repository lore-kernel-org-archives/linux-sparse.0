From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Casting away noderef and address spaces?
Date: Mon, 22 Dec 2008 16:06:13 +1030
Message-ID: <200812221606.13910.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:58231 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbYLVFgV (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 00:36:21 -0500
Received: from vivaldi.localnet (unknown [150.101.102.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPSA id 82C5DDDD01
	for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 16:36:19 +1100 (EST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi all,

  I need to use typeof(), but I want to change address spaces.  I can't see
how to do that: AFAICT it's not possible.  This doesn't work:

#define __percpu __attribute__((noderef, address_space(3)))

/* Turn v back into a normal var. */
#define convert(v) \
	(*(__attribute__((address_space(0), force)) typeof(&v))(v))

int main(int argc, char *argv)
{
	unsigned int __percpu x;

	convert(x) = 0;
	return 0;
}

Thanks,
Rusty.
