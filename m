From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Another potential issue with linearized output
Date: Wed, 22 Mar 2017 00:12:07 +0000
Message-ID: <CACXZuxfcG62TpXyrvnsfmPZFYmHHhrasXR7OxMMuEnJETn3ZgQ@mail.gmail.com>
References: <CACXZuxetXE1QQ2jK5Pc5+FQB-vN3pguUNm8FuJ5hZ23C845KKA@mail.gmail.com>
 <CACXZuxfdKn-x_-nVbLy4PGMpmVDk-_7RESOQcfPT8FLa7JDEzQ@mail.gmail.com> <CACXZuxc9eMUN1HVVUCTG82qMe_ZkzjhJzivdMNN_nhDzi-j3OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33683 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758105AbdCVAMX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 20:12:23 -0400
Received: by mail-io0-f177.google.com with SMTP id f84so57935470ioj.0
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 17:12:08 -0700 (PDT)
In-Reply-To: <CACXZuxc9eMUN1HVVUCTG82qMe_ZkzjhJzivdMNN_nhDzi-j3OA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 21 March 2017 at 22:21, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I have tracked this down to the treatment of variable n2.

Here is a small program that reproduces the issue:

static int regc(void)
{
  char r00, r01, r02;
  int s, n1, n2, j, d[2];
  r00 = 0;
  r01 = 1;
  r02 = 2;
  d[0] = &r01 - &r00;
  d[1] = &r02 - &r01;

  n1 = d[0];
  s = 1;

  for (j = 0; j < 2; j++)
    switch (s) {
    case 1:
      n2 = d[j];
      break;
    case 2:
      if (d[j] == n2) {
        break;
      }
      s = 4;
      break;
    };
  return s;
}

Thanks and Regards
Dibyendu
