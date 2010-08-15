From: Bart Van Assche <bvanassche@acm.org>
Subject: sparse ignores __attribute__((packed))
Date: Sun, 15 Aug 2010 18:15:22 +0200
Message-ID: <AANLkTi=1-hMnZGHix_DC_7_7TcOCo6OrGJx3JYFppN86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41323 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab0HOQPX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 15 Aug 2010 12:15:23 -0400
Received: by vws3 with SMTP id 3so2661487vws.19
        for <linux-sparse@vger.kernel.org>; Sun, 15 Aug 2010 09:15:22 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello,

The test program below compiles fine with gcc 4.5.0 but triggers a
build error with sparse (git repository last updated on July 11). This
seems like a sparse bug to me. Is this a known issue ?

#define BUILD_BUG_ON(e) (void)(sizeof(struct { int:-!!(e); }))

struct s {
=A0=A0=A0 char c;
=A0=A0=A0 int i;
} __attribute__((packed));

int main(int argc, char** argv)
{
=A0=A0=A0 BUILD_BUG_ON(sizeof(struct s) !=3D sizeof(char) + sizeof(int)=
);
=A0=A0=A0 return 0;
}

Bart.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
