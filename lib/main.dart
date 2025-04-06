import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FoodDonationApp());
}

// --- Global Theme Colors ---
const Color primaryColor = Color.fromARGB(255, 208, 67, 255); // Green
const Color secondaryColor = Color.fromARGB(255, 227, 103, 255); // Teal
const Color darkBackgroundColor = Color.fromARGB(255, 24, 18, 18);
const Color darkSurfaceColor = Color.fromARGB(255, 0, 0, 0); // Slightly lighter dark
const Color darkCardColor = Color.fromARGB(255, 75, 54, 108);
const Color darkOnSurfaceColor = Colors.white;
const Color darkOnSurfaceVariantColor = Colors.white70;

class FoodDonationApp extends StatelessWidget {
  const FoodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DonationProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PlateMate',
        theme: ThemeData(
          useMaterial3: true, // Enable Material 3 features
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark(
            primary: primaryColor,
            secondary: secondaryColor,
            surface: darkSurfaceColor,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: darkOnSurfaceColor,
            error: Colors.redAccent,
            onError: Colors.white,
            surfaceContainerHighest: darkCardColor, // Used for cards
            onSurfaceVariant: darkOnSurfaceVariantColor, // Text on cards/inputs
          ),
          scaffoldBackgroundColor: darkBackgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor:
                darkSurfaceColor, // Slightly lighter than background
            elevation: 1, // Subtle shadow
            titleTextStyle: TextStyle(
              color: darkOnSurfaceColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: IconThemeData(color: darkOnSurfaceColor),
            centerTitle: true,
          ),
          cardTheme: CardTheme(
            color: darkCardColor,
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              color: darkOnSurfaceColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            titleLarge: TextStyle(
              color: darkOnSurfaceColor,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ), // Card titles
            bodyLarge: TextStyle(
              color: darkOnSurfaceColor,
              fontSize: 16,
            ), // Main text
            bodyMedium: TextStyle(
              color: darkOnSurfaceVariantColor,
              fontSize: 14,
            ), // Detail text
            labelLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ), // Button text
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: darkSurfaceColor, // Input field background
            labelStyle: const TextStyle(color: darkOnSurfaceVariantColor),
            hintStyle: const TextStyle(color: darkOnSurfaceVariantColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15.0,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white, // Text color
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              elevation: 2,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: secondaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}

// ---------------------------- LOGIN PAGE ----------------------------

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          // Added for smaller screens
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.food_bank_rounded, // Example Logo
                size: 80,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome to PlateMate',
                style: textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  labelText: 'Username',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement actual login logic
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                // Added Sign Up option
                onPressed: () {
                  // TODO: Implement navigation to Sign Up Screen
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------- HOME SCREEN ----------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final donationProvider = Provider.of<DonationProvider>(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PlateMate Donations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none), // Notification Icon
            tooltip: 'Notifications',
            onPressed: () {
              // TODO: Handle notifications action
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined), // Profile Icon
            tooltip: 'Profile',
            onPressed: () {
              // TODO: Handle profile action
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GeminiScreen()),
                );
              },
              icon: const Icon(Icons.chat)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                donationProvider.donations.isEmpty
                    ? Center(
                      child: Column(
                        // Empty State
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.no_food_outlined,
                            size: 60,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No donations available yet.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Check back later or add a donation!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                    : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio:
                                0.75, // Adjust aspect ratio for better fit
                          ),
                      itemCount: donationProvider.donations.length,
                      itemBuilder: (context, index) {
                        final donation = donationProvider.donations[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => DonationDetailsScreen(
                                      donation: donation,
                                    ),
                              ),
                            );
                          },
                          child: Card(
                            // Using CardTheme defined globally
                            clipBehavior:
                                Clip.antiAlias, // Ensures image respects card rounding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3, // Give more space to image
                                  child: Hero(
                                    // Add Hero animation for image transition
                                    tag:
                                        'donation_image_${donation.foodName}_$index', // Unique tag
                                    child:
                                        donation.image != null
                                            ? Image.file(
                                              File(donation.image!),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => _buildPlaceholderImage(
                                                    context,
                                                  ),
                                            )
                                            : Image.network(
                                              // Fallback network image
                                              'https://source.unsplash.com/200x200/?food,meal,plate', // More generic query
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => _buildPlaceholderImage(
                                                    context,
                                                  ),
                                              loadingBuilder: (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    value:
                                                        loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                    strokeWidth: 2,
                                                  ),
                                                );
                                              },
                                            ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2, // Give less space to text details
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly, // Distribute space
                                      children: [
                                        Text(
                                          donation.foodName,
                                          style: textTheme.titleLarge?.copyWith(
                                            fontSize: 16,
                                          ), // Slightly smaller title
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Qty: ${donation.quantity}",
                                          style: textTheme.bodyMedium,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Expires: ${donation.expiryDate}",
                                          style: textTheme.bodyMedium?.copyWith(
                                            fontSize: 12,
                                          ), // Even smaller detail
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
          Padding(
            // Add padding around the request button
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 15,
              top: 5,
            ),
            child: SizedBox(
              width:double.infinity,
              
              child: ElevatedButton.icon(
                
                icon: const Icon(Icons.request_page_outlined),
                label: const Text("Request Food"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestFoodScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  alignment: AlignmentDirectional.bottomStart,
                  backgroundColor:
                      Theme.of(
                        context,
                      ).colorScheme.secondary, // Use secondary color
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Use extended FAB
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DonateFoodScreen()),
            ),
        icon: const Icon(Icons.add),
        label: const Text("Donate"),
      ),
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.fastfood_outlined,
          color: Theme.of(
            context,
          ).colorScheme.onSurfaceVariant.withOpacity(0.5),
          size: 40,
        ),
      ),
    );
  }
}

// ---------------------------- DONATION DETAILS SCREEN ----------------------------

class DonationDetailsScreen extends StatelessWidget {
  final FoodDonation donation;

  const DonationDetailsScreen({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(donation.foodName)),
      body: SingleChildScrollView(
        // Allow scrolling for long descriptions
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                // Match Hero tag from list
                tag:
                    'donation_image_${donation.foodName}_${Provider.of<DonationProvider>(context, listen: false).donations.indexOf(donation)}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child:
                      donation.image != null
                          ? Image.file(
                            File(donation.image!),
                            width:
                                MediaQuery.of(context).size.width *
                                0.6, // Responsive width
                            height: MediaQuery.of(context).size.width * 0.6,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    _buildDetailPlaceholderImage(context),
                          )
                          : Image.network(
                            'https://source.unsplash.com/300x300/?food,meal,${donation.foodName}', // Larger image
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.width * 0.6,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    _buildDetailPlaceholderImage(context),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: MediaQuery.of(context).size.width * 0.6,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            _buildDetailRow(
              context,
              Icons.fastfood_outlined,
              'Food',
              donation.foodName,
              isTitle: true,
            ),
            _buildDetailRow(
              context,
              Icons.category_outlined,
              'Category',
              donation.category.name,
            ),
            _buildDetailRow(
              context,
              Icons.scale_outlined,
              'Quantity',
              donation.quantity,
            ),
            _buildDetailRow(
              context,
              Icons.date_range_outlined,
              'Expires On',
              donation.expiryDate,
            ),
            _buildDetailRow(
              context,
              Icons.access_time_outlined,
              'Best Before',
              donation.bestBeforeTime,
            ),
            _buildDetailRow(
              context,
              Icons.description_outlined,
              'Description',
              donation.description,
            ),
            const SizedBox(height: 30),
            SizedBox(
              // Wrap buttons in SizedBox for width control
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Chat with Donor'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(donation: donation),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.local_shipping_outlined),
                label: const Text('Arrange Pickup'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              PickupArrangementScreen(donation: donation),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool isTitle = false,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isTitle)
                  Text(
                    label,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Text(
                  value,
                  style:
                      isTitle
                          ? textTheme.headlineSmall?.copyWith(fontSize: 22)
                          : textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailPlaceholderImage(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.6;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Theme.of(
            context,
          ).colorScheme.onSurfaceVariant.withOpacity(0.5),
          size: 50,
        ),
      ),
    );
  }
}

// ---------------------------- CHAT SCREEN ----------------------------

class ChatScreen extends StatefulWidget {
  final FoodDonation donation;

  const ChatScreen({super.key, required this.donation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  // In a real app, fetch messages from ChatProvider based on donation/user IDs
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hi! Is the food still available?",
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatMessage(
      text: "Yes, it is. When can you pick it up?",
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    ChatMessage(
      text: "I can come by this evening around 6 PM.",
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: messageText,
            isMe: true, // Assume the current user is the sender
            timestamp: DateTime.now(),
          ),
        );
        _messageController.clear();
        // TODO: In a real app, send the message via ChatProvider/backend
        // Provider.of<ChatProvider>(context, listen: false).addMessage(widget.donation.id, newMessage);
      });
      // Simulate a reply after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add(
            ChatMessage(
              text: "Okay, sounds good!",
              isMe: false,
              timestamp: DateTime.now(),
            ),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat about ${widget.donation.foodName}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Show latest messages at the bottom
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final reversedIndex =
                    _messages.length -
                    1 -
                    index; // Access messages in reverse for display
                final message = _messages[reversedIndex];
                return ChatBubble(message: message);
              },
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color:
            colorScheme.surface, // Use surface color for input area background
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                fillColor:
                    colorScheme
                        .surface, // Slightly different background for input field itself
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: colorScheme.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              style: TextStyle(color: colorScheme.onSurface),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted:
                  (_) => _sendMessage(), // Send on keyboard done action
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send_rounded),
            color: colorScheme.primary,
            tooltip: 'Send Message',
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

// --- Chat Message Model ---
class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}

// --- Chat Bubble Widget ---
class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMe = message.isMe;
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color =
        isMe ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest;
    final textColor =
        isMe ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant;
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(4),
      bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(18),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ), // Limit bubble width
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
        child: Column(
          // Add timestamp below message
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat(
                'hh:mm a',
              ).format(message.timestamp), // Format timestamp
              style: theme.textTheme.bodySmall?.copyWith(
                color: textColor.withOpacity(0.7),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------- PICKUP ARRANGEMENT SCREEN ----------------------------

class PickupArrangementScreen extends StatefulWidget {
  final FoodDonation donation;

  const PickupArrangementScreen({super.key, required this.donation});

  @override
  State<PickupArrangementScreen> createState() =>
      _PickupArrangementScreenState();
}

class _PickupArrangementScreenState extends State<PickupArrangementScreen> {
  final _formKey = GlobalKey<FormState>(); // Add form key for validation
  TimeOfDay? _selectedTime;
  String? _pickupLocation;
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController =
      TextEditingController(); // Optional notes

  @override
  void dispose() {
    _timeController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      helpText: 'Select Pickup Time', // More descriptive help text
      builder: (context, child) {
        // Apply theme to picker
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary:
                  Theme.of(
                    context,
                  ).colorScheme.primary, // Use your primary color
            ),
            // You might need to customize textButtonTheme as well for buttons
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text = _selectedTime!.format(context);
      });
    }
  }

  void _confirmArrangement() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, show confirmation dialog
      _showConfirmationDialog(context);
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    final theme = Theme.of(context);
    final pickupTime = _selectedTime?.format(context) ?? "Not selected";
    final pickupLocation = _locationController.text.trim();
    final notes = _notesController.text.trim();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Confirm Pickup Details',
            style: theme.textTheme.titleLarge,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Food: ${widget.donation.foodName}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text('Time: $pickupTime', style: theme.textTheme.bodyMedium),
              Text(
                'Location: $pickupLocation',
                style: theme.textTheme.bodyMedium,
              ),
              if (notes.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('Notes: $notes', style: theme.textTheme.bodyMedium),
              ],
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              // Use ElevatedButton for confirmation
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
              ),
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // TODO: Implement actual confirmation logic (send notification, update DB)
                print(
                  'Pickup Confirmed: Time: $pickupTime, Location: $pickupLocation, Notes: $notes',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Pickup arrangement confirmed! Donor notified.',
                    ),
                    backgroundColor:
                        theme
                            .colorScheme
                            .primary, // Use primary color for success
                    behavior: SnackBarBehavior.floating, // Modern look
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
                // Optionally navigate back or clear fields
                Navigator.pop(
                  context,
                ); // Go back from pickup arrangement screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Arrange Pickup')),
      body: SingleChildScrollView



      (
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // Wrap in Form
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Arrange pickup for:', style: textTheme.bodyMedium),
              Text(
                widget.donation.foodName,
                style: textTheme.titleLarge?.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Preferred Pickup Time',
                  prefixIcon: Icon(
                    Icons.access_time_outlined,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a pickup time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Pickup Location Address',
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the pickup location';
                  }
                  return null;
                },
                onChanged: (value) {
                  // No need for setState here unless tracking live changes elsewhere
                   _pickupLocation = value;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                // Optional Notes field
                controller: _notesController,
                decoration: InputDecoration(
                  labelText:
                      'Optional Notes (e.g., contact info, instructions)',
                  prefixIcon: Icon(
                    Icons.note_alt_outlined,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _confirmArrangement,
                  child: const Text('Confirm Pickup Arrangement'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------- DONATION PROVIDER ----------------------------

// Enum for food categories
enum FoodCategory {
  veg("Vegetarian"),
  nonVeg("Non-Vegetarian"),
  vegan("Vegan"),
  other("Other"); // Added 'Other'

  final String displayName;
  const FoodCategory(this.displayName);
}

class FoodDonation {
  final String foodName;
  final String
  expiryDate; // Should ideally be DateTime, but keeping String for simplicity based on original code
  final String? image; // Path to local image file
  final String quantity; // e.g., "2 packs", "500g"
  final String description;
  final String
  bestBeforeTime; // Should ideally be TimeOfDay/DateTime, keeping String
  final FoodCategory category;

  // Add a simple ID (in real app, this would come from a database)
  final String id;

  FoodDonation({
    required this.foodName,
    required this.expiryDate,
    this.image,
    required this.quantity,
    required this.description,
    required this.bestBeforeTime,
    required this.category,
  }) : id =
           DateTime.now().millisecondsSinceEpoch
               .toString(); // Simple unique ID generation
}

class DonationProvider extends ChangeNotifier {
  // Add some initial dummy data for demonstration
  final List<FoodDonation> _donations = [
    FoodDonation(
      foodName: "Homemade Lasagna",
      expiryDate: DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.now().add(const Duration(days: 2))),
      quantity: "2 Plate Chole Bhature (feeds 4-6)",
      description: "Chole Bhature is a popular North Indian dish consisting of spicy chickpea curry (chole) served with deep-fried fluffy bread (bhature)",
      bestBeforeTime: "8:00 PM",
      category: FoodCategory.veg,
      image: null, // Will use network image
    ),
    FoodDonation(
      foodName: "Fresh Bread Loaf",
      expiryDate: DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.now().add(const Duration(days: 1))),
      quantity: "1 loaf",
      description: "Sourdough bread, baked this morning.",
      bestBeforeTime: "10:00 PM",
      category: FoodCategory.vegan,
      image: null, // Will use network image
    ),
    FoodDonation(
      foodName: "Vegetable Curry",
      expiryDate: DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.now().add(const Duration(days: 3))),
      quantity: "Approx 1 litre",
      description: "Mild coconut-based vegetable curry with rice.",
      bestBeforeTime: "9:00 PM",
      category: FoodCategory.veg,
      image: null, // Will use network image
    ),
  ];

  List<FoodDonation> get donations => _donations;

  void addDonation(FoodDonation donation) {
    // Add to the beginning of the list so new items appear first
    _donations.insert(0, donation);
    notifyListeners();
  }

  void removeDonation(String id) {
    _donations.removeWhere((d) => d.id == id);
    notifyListeners();
  }
}

// ---------------------------- DONATE FOOD SCREEN ----------------------------

class DonateFoodScreen extends StatefulWidget {
  const DonateFoodScreen({super.key});

  @override
  State<DonateFoodScreen> createState() => _DonateFoodScreenState();
}

class _DonateFoodScreenState extends State<DonateFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _bestBeforeTimeController =
      TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker(); // Use instance variable
  FoodCategory _selectedCategory = FoodCategory.veg; // Default selection
  DateTime? _selectedExpiryDate;
  TimeOfDay? _selectedBestBeforeTime;

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 800,
      ); // Compress image

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error picking image. Please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      // Use bottom sheet for modern feel
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          // Ensure content doesn't overlap system UI
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Take Photo'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          _selectedExpiryDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(), // Can't select past dates
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ), // Limit to 1 year
      helpText: 'Select Expiry Date',
      builder: (context, child) {
        // Apply theme to picker
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedExpiryDate) {
      setState(() {
        _selectedExpiryDate = pickedDate;
        _expiryDateController.text = DateFormat(
          'yyyy-MM-dd',
        ).format(pickedDate);
      });
    }
  }

  Future<void> _selectBestBeforeTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedBestBeforeTime ?? TimeOfDay.now(),
      helpText: 'Select Best Before Time',
      builder: (context, child) {
        // Apply theme to picker
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != _selectedBestBeforeTime) {
      setState(() {
        _selectedBestBeforeTime = pickedTime;
        _bestBeforeTimeController.text = pickedTime.format(context);
      });
    }
  }

  void _submitDonation() {
    if (_formKey.currentState!.validate()) {
      // All fields are valid
      final donationProvider = Provider.of<DonationProvider>(
        context,
        listen: false,
      );

      final newDonation = FoodDonation(
        foodName: _foodNameController.text.trim(),
        expiryDate: _expiryDateController.text,
        image: _image?.path,
        quantity: _quantityController.text.trim(),
        description: _descriptionController.text.trim(),
        bestBeforeTime: _bestBeforeTimeController.text,
        category: _selectedCategory,
      );

      donationProvider.addDonation(newDonation);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Donation added successfully! Thank you.'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Clear form and navigate back
      _formKey.currentState?.reset();
      _foodNameController.clear();
      _expiryDateController.clear();
      _quantityController.clear();
      _descriptionController.clear();
      _bestBeforeTimeController.clear();
      setState(() {
        _image = null;
        _selectedCategory = FoodCategory.veg;
        _selectedExpiryDate = null;
        _selectedBestBeforeTime = null;
      });

      Navigator.pop(context); // Go back to home screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all required fields correctly.'),
          backgroundColor: Colors.orangeAccent, // Warning color
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _expiryDateController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    _bestBeforeTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Donation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Make button full width
            children: [
              Center(
                // Center the image picker
                child: GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color:
                          colorScheme
                              .surfaceContainerHighest, // Use card color for placeholder bg
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color:
                            _image == null
                                ? colorScheme.onSurfaceVariant.withOpacity(0.3)
                                : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child:
                        _image != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                14,
                              ), // Slightly smaller radius than container
                              child: Image.file(_image!, fit: BoxFit.cover),
                            )
                            : Column(
                              // Placeholder content
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: colorScheme.onSurfaceVariant,
                                  size: 50,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Add Food Photo',
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _foodNameController,
                decoration: const InputDecoration(
                  labelText: 'Food Name *',
                  prefixIcon: Icon(Icons.fastfood_outlined),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the food name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity * (e.g., 2 packs, 500g)',
                  prefixIcon: Icon(Icons.scale_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date *',
                  prefixIcon: Icon(Icons.date_range_outlined),
                ),
                readOnly: true,
                onTap: () => _selectExpiryDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the expiry date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _bestBeforeTimeController,
                decoration: const InputDecoration(
                  labelText: 'Best Before Time *',
                  prefixIcon: Icon(Icons.access_time_outlined),
                ),
                readOnly: true,
                onTap: () => _selectBestBeforeTime(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the best before time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Dropdown using DropdownButtonFormField for better integration and validation
              DropdownButtonFormField<FoodCategory>(
                decoration: const InputDecoration(
                  labelText: 'Category *',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                value: _selectedCategory,
                // Use the enum's display name for the text
                items:
                    FoodCategory.values.map((category) {
                      return DropdownMenuItem<FoodCategory>(
                        value: category,
                        child: Text(category.displayName),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
                dropdownColor:
                    colorScheme
                        .surfaceContainerHighest, // Match card color for dropdown background
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description * (allergens, details)',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitDonation,
                child: const Text('Add Donation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//---------------------------- REQUEST FOOD PROVIDER AND SCREEN ----------------------------

class FoodRequest {
  final String foodName;
  final String quantity;
  final String description;
  final DateTime requestTime; // Add timestamp

  FoodRequest({
    required this.foodName,
    required this.quantity,
    required this.description,
  }) : requestTime = DateTime.now();
}

class RequestProvider extends ChangeNotifier {
  final List<FoodRequest> _requests = [];

  List<FoodRequest> get requests => _requests;

  void addRequest(FoodRequest request) {
    _requests.insert(0, request); // Add new requests to the top
    notifyListeners();
  }

  void removeRequest(FoodRequest request) {
    _requests.remove(request);
    notifyListeners();
  }

  // Could add methods to view/manage requests later
}

class RequestFoodScreen extends StatefulWidget {
  const RequestFoodScreen({super.key});

  @override
  State<RequestFoodScreen> createState() => _RequestFoodScreenState();
}

class _RequestFoodScreenState extends State<RequestFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController(); // Now mandatory

  @override
  void dispose() {
    _foodNameController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      final newRequest = FoodRequest(
        foodName: _foodNameController.text.trim(),
        quantity: _quantityController.text.trim(),
        description: _descriptionController.text.trim(),
      );

      // Add request using Provider
      Provider.of<RequestProvider>(
        context,
        listen: false,
      ).addRequest(newRequest);

      print('Food Request Submitted:');
      print('  Food Name: ${newRequest.foodName}');
      print('  Quantity: ${newRequest.quantity}');
      print('  Description: ${newRequest.description}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Food request submitted successfully!'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Clear the form and navigate back
      _formKey.currentState?.reset();
      _foodNameController.clear();
      _quantityController.clear();
      _descriptionController.clear();
      Navigator.pop(context); // Go back after successful submission
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all required fields.'),
          backgroundColor: Colors.orangeAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using global theme's InputDecorationTheme, no need to redefine here
    // InputDecoration inputDecoration(String labelText, IconData icon) { ... }

    return Scaffold(
      appBar: AppBar(title: const Text('Request Food Item')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  // Add introductory text
                  'Need a specific food item? Let donors know what you\'re looking for.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _foodNameController,
                  decoration: const InputDecoration(
                    labelText: 'Food Item Name *',
                    prefixIcon: Icon(Icons.shopping_basket_outlined),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the food name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Required Quantity * (e.g., 1 bottle, 2 kg)',
                    prefixIcon: Icon(Icons.format_list_numbered),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the required quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText:
                        'Reason / Description * (Why you need it, specifics)',
                    prefixIcon: Icon(Icons.info_outline),
                  ),
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please provide a reason or description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitRequest,
                  child: const Text('Submit Food Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//---------------------------- CHAT PROVIDER ----------------------------

class ChatProvider extends ChangeNotifier {
  // Placeholder for chat management logic.
  // In a real app, this would handle storing and retrieving messages
  // possibly grouped by donation ID or involved users.

  // Example structure (replace with actual implementation):
  final Map<String, List<ChatMessage>> _chats = {};

  void addMessage(String chatId, ChatMessage message) {
    _chats.putIfAbsent(chatId, () => []).add(message);
    notifyListeners();
  }

  List<ChatMessage> getMessages(String chatId) {
    return _chats[chatId] ?? [];
  }

  void clearChat(String chatId) {
     _chats.remove(chatId);
     notifyListeners();
  }
}

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {
  final _promptController = TextEditingController();
  String _outputText = 'Enter a prompt and tap Generate';
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

 Future<void> _generateText() async {
  setState(() {
    _isLoading = true;
    _errorMessage = '';
    _outputText = '';
  });

  try {
    final gemini = GenerativeModel(
      model: 'gemini-2.0-flash', // Use 'gemini-1.5' or 'gemini-pro' if needed
      apiKey: 'AIzaSyD6N11putqjtqbf6n69a5GT_Vv-wdWvmXQ',
    );

    final prompt = _promptController.text;
    final content = [Content.text(prompt)];

    final responseStream = gemini.generateContentStream(content);

    await for (final chunk in responseStream) {
      setState(() {
        _outputText += chunk.text ?? '';
      });
    }
  } catch (e) {
    setState(() {
      _errorMessage = 'Error: ${e.toString()}';
      _outputText = 'An error occurred. See error message above.';
    });
    print('Gemini API Error: ${e.toString()}');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlateMate Gemini'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _promptController,
              decoration: const InputDecoration(
                labelText: 'Enter Prompt',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _generateText,
              child: _isLoading ? const CircularProgressIndicator() : const Text('Generate'),
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _outputText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
