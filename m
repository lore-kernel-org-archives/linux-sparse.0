From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Sparse parsing question: string literal
Date: Sun, 20 Aug 2017 13:31:54 +0100
Message-ID: <CACXZuxcvbCc+eOyqzrUUs4qkTpS705u065nc5=H8DLJ9AQnCEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33518 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbdHTMbz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 08:31:55 -0400
Received: by mail-vk0-f48.google.com with SMTP id j189so43493395vka.0
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 05:31:55 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am looking at the parse tree for following snippet:

void main(int argc, const char *argv[])
{
5;
6.5;
"hello";
}

I see that 5 is treated as EXPR_VALUE, 6.5 as EXPR_FVALUE, but "hello"
is treated as EXPR_SYMBOL. Why is that?

Thanks and Regards
Dibyendu
