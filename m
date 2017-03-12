From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Trying to understand linearized output
Date: Sun, 12 Mar 2017 14:11:37 +0000
Message-ID: <CACXZuxfTBH2hr8kOXepJ7VGCrfvjMU3h8GhDfZhtPEA6Ynw6jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:34975 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933820AbdCLOLj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 10:11:39 -0400
Received: by mail-it0-f41.google.com with SMTP id m27so17230235iti.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 07:11:38 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi

I am trying to understand following.

The function in question is shown below and is compiled as part of a
larger program with other functions.

/* find the next object in the tree */
void           *
AVLTree_FindNext(AVLTree * tree, void *currnode)
{
 AVLNode        *current;
 current = (AVLNode *) currnode;
 if (current) {
  --current;
  if (current->right) {
   current = current->right;
   while (current->left != NULL)
    current = current->left;
  } else {
   AVLNode        *p;
   p = current;
   current = p->parent;
   while (current) {
    if (current->right == p) {
     p = current;
     current = current->parent;
    } else
     break;
   }
  }
 }
 if (current)
  return (void *) (current + 1);
 else
  return NULL;
}

The linearized output is:

AVLTree_FindNext:
.L125:
 <entry-point>
 ptrcast.64  %r333 <- (64) %arg2
 phisrc.64   %phi98(current) <- %r333
 br          %r333, .L126, .L127
.L126:
 add.64      %r336 <- %r333, $-32
 load.64     %r338 <- -16[%r333]
 br          %r338, .L128, .L129
.L128:
 phisrc.64   %phi108(current) <- %r338
 br          .L133
.L133:
 phi.64      %r341(current) <- %phi108(current), %phi109(current)
 load.64     %r342 <- 8[%r341(current)]
 phisrc.64   %phi99(current) <- %r341(current)
 br          %r342, .L130, .L127
.L130:
 phisrc.64   %phi109(current) <- %r342
 br          .L133
.L129:
 load.64     %r348(current) <- -32[%r333]
 phisrc.64   %phi104(current) <- %r348(current)
 phisrc.64   %phi112(p) <- %r336
 br          .L138
.L138:
 phi.64      %r349(current) <- %phi104(current), %phi105(current)
 phisrc.64   %phi100(current) <- %r349(current)
 br          %r349(current), .L135, .L127
.L135:
 load.64     %r351 <- 16[%r349(current)]
 phi.64      %r352 <- %phi112(p), %phi113(p)
 seteq.32    %r353 <- %r351, %r352
 phisrc.64   %phi101(current) <- %r349(current)
 br          %r353, .L139, .L127
.L139:
 load.64     %r356 <- 0[%r349(current)]
 phisrc.64   %phi105(current) <- %r356
 phisrc.64   %phi113(p) <- %r349(current)
 br          .L138
.L127:
 phi.64      %r357(current) <- %phi98(current), %phi99(current),
%phi100(current), %phi101(current)
 br          %r357(current), .L142, .L143
.L142:
 add.64      %r359 <- %r357(current), $32
 cast.64     %r360 <- (64) %r359
 phisrc.64   %phi95(return) <- %r360
 br          .L144
.L143:
 phisrc.64   %phi96(return) <- $0
 br          .L144
.L144:
 phi.64      %r361 <- %phi95(return), %phi96(return)
 ret.64      %r361


My question is:

phisrc.64   %phi98(current) <- %r333

The phi98 above is presumably referencing a pseudo which has number
98. But this is not part of this function, so I am confused. Does this
look right?

Thanks and Regards
Dibyendu
