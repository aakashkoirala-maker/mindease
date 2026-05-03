package com.mindease.service;

import com.mindease.dao.ContactMessageDAO;
import com.mindease.model.ContactMessage;

import java.util.List;

public class ContactMessageService {
    private final ContactMessageDAO messageDAO = new ContactMessageDAO();

    public int createMessage(ContactMessage message) {
        return messageDAO.createMessage(message);
    }

    public List<ContactMessage> getMessagesByUserId(int userId) {
        return messageDAO.getMessagesByUserId(userId);
    }

    public ContactMessage getMessageById(int messageId) {
        return messageDAO.getMessageById(messageId);
    }

    public List<ContactMessage> getAllMessages() {
        return messageDAO.getAllMessages();
    }

    public boolean replyToMessage(int messageId, String adminReply) {
        return messageDAO.replyToMessage(messageId, adminReply);
    }
}

